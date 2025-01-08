% paireplot.m - draws the graph to pre-analyse data
%
% Inputs: 
%   D - structure containing clip-aligned data
%   N - number of clips (or trials)
%
% Outpts:
%   Graphs:
%       Eye position (x/y) (deg) vs time
%       Pupil diameter (mm) vs time
%       Pupil velocity (mm/s) vs time
%       Vertical vs horizontal eye position (deg)
% ------------- BEGIN CODE -------------- %
%% Trial bounds 
if trn < 1, trn = 1; end
if trn > N, trn = N; end

%% Title
%  paiGoodBadToggle;
set(f,'name',['PAI: Pupil Analysis Interface' ' trial # ' num2str(trn)]);

%% Plot time-dependent data
% Eye position (degrees) vs time 
axes(ax(1));
cla; hold on;
plot(D(trn).timestamps, D(trn).eyeX, 'r'); % Eye X
plot(D(trn).timestamps, D(trn).eyeY, 'g'); % Eye Y
legend('Horizontal', 'Vertical');
set(ax(1), 'xlim', [D(trn).timestamps(1), D(trn).timestamps(end)], 'ylim', [-40, 40]);

% Pupil size vs time 
axes(ax(2));
cla; hold on;
plot(D(trn).timestamps, D(trn).pupilSize, 'b'); % Pupil Size
set(ax(2), 'xlim', [D(trn).timestamps(1), D(trn).timestamps(end)]);

% Pupil velocity vs time
% axes(ax(3));
% cla; hold on;
% pupilSize = double(D(trn).pupilSize); % Convert to double
% timestamps = double(D(trn).timestamps(:)); % Convert to column vector
% pupilVelocity = diff(pupilSize) ./ diff(timestamps); % Pixels²/ms
% timeMidpoints = timestamps(1:end-1) + diff(timestamps) / 2; % Time midpoints
% plot(timeMidpoints, pupilVelocity, 'm'); % Pupil Velocity
% set(ax(3), 'xlim', [timestamps(1), timestamps(end)], 'ylim', [-1000, 1000]);

%% Plot spatial data
% Vertical eye position (deg) vs horizontal eye position (deg)
axes(ax(5));
cla; hold on;
plot(D(trn).eyeX, D(trn).eyeY, 'k'); % Eye Position
set(ax(5), 'xlim', [-40, 40], 'ylim', [-40, 40]);

%% finalize
set(h,'visible','on')