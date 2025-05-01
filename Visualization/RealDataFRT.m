function RealDataFRT(results, results_sv, fieldName, UpdateperSeq)
    % derive data
    charAcc_results = results.(fieldName).CharAccu; 
    charAccuFRT_results = results.(fieldName).CharAccuFRT;
    numIterations = size(charAcc_results, 1);

    charAcc_results_sv = results_sv.(fieldName).CharAccu; 
    charAccuFRT_results_sv = results_sv.(fieldName).CharAccuFRT;
    numIterations_sv = size(charAcc_results_sv, 1);

    % calculate mean
    meanCharAcc_results = mean(charAcc_results, 2); 
    meanCharAccuFRT_results = mean(charAccuFRT_results);
    
    meanCharAcc_results_sv = mean(charAcc_results_sv, 2); 
    meanCharAccuFRT_results_sv = mean(charAccuFRT_results_sv);

    % re arrange x-axis
    x_results = 15:UpdateperSeq:(15 + (numIterations - 1) * 2);
    x_results_sv = 1:numIterations_sv;

    % make sure the length consistent
    minLength = min(length(x_results), length(meanCharAcc_results));
    x_results = x_results(1:minLength);
    meanCharAcc_results = meanCharAcc_results(1:minLength);

    % plot
    figure; hold on;

    % Adaptive FRT 
    plot(x_results, meanCharAcc_results, 'Color', [1, 0.5, 0], 'LineWidth', 1.5); % blue
    plot(x_results_sv, meanCharAcc_results_sv, 'b', 'LineWidth', 1.5); % orange (RGB)
    
    % Offline FRT 
    yline(meanCharAccuFRT_results, '--black', 'LineWidth', 1.5); % red
    yline(meanCharAccuFRT_results_sv, '--g', 'LineWidth', 1.5); % green

    % 
    legend({'Adaptive Semi-Supervised', 'Adaptive Supervised', ...
            'Offline Semi-Supervised', 'Offline Supervised'}, ...
            'Location', 'Southeast');

    % 
    xlabel('Number of Sequence');
    ylabel('Character Accuracy');
    %title(['Character Accuracy over Iterations - ', fieldName]);

    % 
    grid on;
    xlim([0, max(x_results_sv)]);
    ylim([0, 1]); 
    hold off;
end
