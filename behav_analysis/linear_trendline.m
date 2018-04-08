%============= LINEAR FIT ===================================
x = linspace(-10, 10, 20); % Make 20 samples along the x axis
% Create a sample training set, a linear relation, with noise
slope = 1.5;
intercept = -1;
noiseAmplitude = 15;
y = slope .* x + intercept + noiseAmplitude * rand(1, length(x));

% Plot the training set of data.
subplot(2, 1, 1);
plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlabel('X');
ylabel('Y');
title('Linear Fit');

% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 

% Do the regression with polyfit
linearCoefficients = polyfit(x, y, 1);
% The x coefficient, slope, is coefficients(1).
% The constant, the intercept, is coefficients(2).
% Make fit.  It does NOT need to have the same
% number of elements as your training set, 
% or the same range, though it could if you want.
% Make 50 fitted samples going from -15 to +20.
xFit = linspace(-15, 20, 50);
% Get the estimated values with polyval()
yFit = polyval(linearCoefficients, xFit);
% Plot the fit
hold on;
plot(xFit, yFit, 'b.-', 'MarkerSize', 15, 'LineWidth', 1);
legend('Training Set', 'Fit', 'Location', 'Northwest');
