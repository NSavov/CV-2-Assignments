function [fig] = plot_error(x, fig, f_name)
%OUR_PLOT Summary of this function goes here
%   Detailed explanation goes here
    global param_is_plotting
    global param_is_timing
    global param_is_testing_tolerance
    global param_is_testing_stability
    if param_is_plotting && ~(param_is_timing || param_is_testing_tolerance || param_is_testing_stability)
        if isempty(fig)
           fig(2) = figure;
           fig(1) = plot(x);
        end
        set(fig(1), 'XData', 1:length(x));
        set(fig(1), 'YData', x);
        refreshdata;
        drawnow;
        if nargin < 3 
            f_name = []; 
        end
        if ~isempty(f_name)
           saveas(fig(2), strcat('plots/', f_name));
           print(fig(2), '-dpdf', strcat('plots/', f_name, '_error', num2str(round(x(end), 3)), '.pdf'));
        end
    end
end

