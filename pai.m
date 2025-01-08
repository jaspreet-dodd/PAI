%% PAI.m - this script builds the GUI used to mark pupil data. This file is
% needed to run all other files and functions.
%
% FreeViewing (FV) Pupil Analysis Interface (PAI)
%
% Inputs: pai.m requires:
%   .mat - seperate files for each movie and each participant (e.g.,
%   subj1_movie1.mat)
%
% Outputs: tba
%
% Dependency: paiload, paireplot, paiGoodBadToggle
%
% See also: caisac.m, caipursuitdmla.m, GRAI.m
%
% Notes: modified from previous interfaces (i.e., cai and GRAI) originally
% written by Chanel, Gunnar Blohm, William Le, Sydney Dore
%
% Author: Jaspreet Dodd
% Email: jaspreet.dodd @ queensu.ca
% Last revised: 22.11.2024

%% BEGIN CODE
clear
warning off

%% create figure
f = figure('Name', 'PAI: Pupil Analysis Interface', ...
    'Units', 'normalized', 'Position', [.01 .01 .98 .94], 'ToolBar',...
    'none', 'NumberTitle', 'off');
%% create axes 
% Creating axes for eye position, pupil size, and pupil velocity
ylab = {'Eye pos (deg)', 'Pupil diameter (pixels^2)', 'Pupil velo (pixels^2/ms)'};
for i = 1:3
    ax(i) = axes('Units', 'normalized', 'Position',[.05 1.02-i*.23 .5 .19]);
    ylabel(ylab{i});
end 
xlabel('Time (ms)')

% Creating axes for vertical vs horizontal eye position 
ax(5) = axes('Units','normalized','Position',[.48 .35 .6 .6],...
    'PlotBoxAspectRatio',[1 1 1]);
xlabel('Horizontal eye position (deg)')
ylabel('Vertical eye position (deg)')

%% initialize basic variables
trn = 1; 

%% add menu items 
gm(1) = uimenu('label', '        PAI        ');
gm(2) = uimenu(gm(1),'label','Load block of data...','callback','[D,N]=paiload;trn=1;paireplot');
gm(3) = uimenu(gm(1), 'label', 'Extract parameters', 'callback', 'paiextract');

%% add buttons and controls 
% Edit button
h.edit = uicontrol('Style','edit','Visible','off',...
   'units','normalized','Position', [0.875 0.25 0.025 0.025]);

% Go button 
h.go = uicontrol('Style','pushbutton','String','Go','Visible','off',...
   'units','normalized','Position', [0.9 0.25 0.025 0.025], 'Callback',...
   'trn=str2num(get(h.edit,''String''));paireplot');

% Trials: good or bad
h.trialGood = uicontrol('Style', 'pushbutton', 'String', 'Trial GOOD', 'foregroundcolor', 'g',...
   'units','normalized','Position', [0.6 0.25 0.05 0.025],'Visible','on',...
   'Callback','D{trn}.good=rem(D{trn}.good+1,2);paigoodbadtoggle');

% Next trial
h.nextTrial = uicontrol('Style', 'pushbutton', 'String', 'Next trial','Visible','on',...
   'units','normalized','Position', [0.75 0.25 0.05 0.025], 'Callback', 'trn=trn+1;paireplot');

% Previous trial
h.previousTrial = uicontrol('Style', 'pushbutton', 'String', 'Previous trial','Visible','on',...
   'units','normalized','Position', [0.7 0.25 0.05 0.025], 'Callback', 'trn=trn-1;paireplot');

% Go to trial
h.goToTrial = uicontrol('Style','text','String','Go to trial #','Visible','on',...
   'units','normalized','Position', [0.825 0.25 0.05 0.025]);

% END CODE




