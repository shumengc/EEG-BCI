function NaiveFRT(numSimu, FilteredSimOutput, SummaryNaive, numIter, UpdateperSeq)
    figure('Position', [200, 200, 500, 400]);
    
    % define x-axis
    numIterations = size(SummaryNaive.CharAccFRTNaive, 2);
    x_summary = 1:numIterations;
    x_filtered = 10:UpdateperSeq:(10 + (numIter - 1) * 2);

    % extract data
    CharAccuAllFRT = nan(numSimu, numIter);
    CharAccuOfflineFRT = nan(numSimu, 1);
    
    for i = 1:numSimu
        simField = sprintf('Simulation_%d', i);
        if isfield(FilteredSimOutput, simField)
            CharAccuAllFRT(i, :) = FilteredSimOutput.(simField).CharAccuAllFRT;
            CharAccuOfflineFRT(i) = FilteredSimOutput.(simField).CharAccuOfflineFRT;
        end
    end

    % mean and standard error
    filteredMean = mean(CharAccuAllFRT, 1);
    filteredStd = std(CharAccuAllFRT, 0, 1);

    summaryMean = mean(SummaryNaive.CharAccFRTNaive, 1);
    summaryStd = std(SummaryNaive.CharAccFRTNaive, 0, 1);

    offlineMeanFiltered = mean(CharAccuOfflineFRT);
    offlineMeanSummary = mean(SummaryNaive.CharAccuFRTFNaive);


    filteredUpper = min(filteredMean + filteredStd, 1);
    filteredLower = max(filteredMean - filteredStd, 0);

    summaryUpper = min(summaryMean + summaryStd, 1);
    summaryLower = max(summaryMean - summaryStd, 0);

    % plot
    hold on;

    % Semi-Supervised Adaptive
    fill([x_filtered, fliplr(x_filtered)],...
         [filteredUpper, fliplr(filteredLower)],...
         [1, 0.5, 0], 'FaceAlpha', 0.25, 'EdgeColor', 'none');

    % Supervised Adaptive
    fill([x_summary, fliplr(x_summary)],...
         [summaryUpper, fliplr(summaryLower)],...
         'b', 'FaceAlpha', 0.25, 'EdgeColor', 'none');

    % mean
    h1 = plot(x_filtered, filteredMean, 'o-', 'Color', [1, 0.5, 0], 'LineWidth', 1.5, 'MarkerSize', 4);
    h2 = plot(x_summary, summaryMean, 's-', 'Color', 'b', 'LineWidth', 1.5, 'MarkerSize', 4);

    % offline
    h3 = plot([x_filtered(1), x_filtered(end)], [offlineMeanFiltered, offlineMeanFiltered],...
        'k--', 'LineWidth', 1.5);

    h4 = plot([x_summary(1), x_summary(end)], [offlineMeanSummary, offlineMeanSummary],...
        'g--', 'LineWidth', 1.5);

    % legend
    legend([h1, h2, h3, h4],...
        {'Semi-Supervised Adaptive (with error bar)',...
         'Supervised Adaptive (with error bar)',...
         'Semi-Supervised Offline (Mean)',...
         'Supervised Offline (Mean)'},...
        'Location', 'Southeast');
    
    xlabel('Number of Sequence');
    ylabel('Character Level Accuracy');
    grid on;
    xlim([0, max(x_summary)]);
    ylim([0, 1.05]); 
    hold off;
    saveas(gcf, 'FRT1_Visualization.png');
end
