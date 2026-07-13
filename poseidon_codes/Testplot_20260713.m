%% MATLAB test code - JP Math Review

[X,Y] = meshgrid(-5:.5:5);
Z = Y.*sin(X) - X.*cos(Y);

fprintf('Variables done \n');
%% Make a plot and save figure

fig = figure('DefaultAxesFontSize',16);
s = surf(X,Y,Z);
h = colorbar;
box on
title('Test plot: $y \cdot sin(x) - x \cdot cos(y)$', 'interpreter', 'latex')
xlabel('x (unit)', 'interpreter', 'latex')
ylabel('y (unit)', 'interpreter', 'latex')
ylabel(h,'z (unit)', 'interpreter', 'latex')
daspect([1 1 1])

% Axes configuration (font style and font size)
ax_fs = 14;
ax_font = 'Times New Roman';

ax = gca;
ax.XAxis.FontSize = ax_fs;
ax.XAxis.FontName = ax_font;
ax.YAxis.FontSize = ax_fs;
ax.YAxis.FontName = ax_font;
ax.ZAxis.FontSize = ax_fs;
ax.ZAxis.FontName = ax_font;
ax.Colorbar.FontSize = ax_fs;
ax.Colorbar.FontName = ax_font;

% figure scaling
fig.Units               = 'centimeters';
fig.Position(3)         = 12.0; %width
fig.Position(4)         = 15.0; %height

% Save figure
figname = './testplot.png';
exportgraphics(fig,figname,"Resolution",150)

%% Write some indicator in the log file when finish
fprintf('Test plotting - DONE \n');
