function [D,N] = paiload
% The purpose of this function is to load and process participant data from a selected .mat file. 
%
% Inputs:
%   .mat file (processed using participantdata.m)
%
% Outputs:
%   D - structure containing clip-aligned data
%   N - number of clips (or trials)
%
% Dependency: none
% ------------- BEGIN CODE -------------- %

%% GUI file select
 [fileName, filePath] = uigetfile('*.mat', 'Select a participant movie data file...'); %.mat
    if isequal(fileName, 0)
        disp('File selection canceled.');
        D = [];
        N = 0;
        return;
    end

%% Extract participant and movie information from the file name
% e.g., subj1_movie10.mat so, participantIdx = 1, movieIdx = 10 
 tokens = regexp(fileName, 'subj(\d+)_movie(\d+).mat', 'tokens');
    if isempty(tokens)
        error('Selected file name does not match the expected format: subjX_movieY.mat');
    end

    participantIdx = str2double(tokens{1}{1});
    movieIdx = str2double(tokens{1}{2});

%% Load selected file 
fullFilePath = fullfile(filePath, fileName);
movieData = load(fullFilePath);

%% Extract clips (or trials) from loaded data
if ~isfield(movieData, 'clip')
    error('The selected file does not contain the expected "clip" field.');
end

clips = movieData.clip;
numClips = length(clips);

%% Populate D structure
D = struct();
for clipIdx = 1:numClips
    D(clipIdx).movie = movieIdx; % Movie number
    D(clipIdx).clip  = clipIdx; % Clip number
    D(clipIdx).timestamps = clips(clipIdx).time; % Timepoints
    D(clipIdx).eyeX = clips(clipIdx).eyeX; % Eye X positions
    D(clipIdx).eyeY = clips(clipIdx).eyeY; % Eye Y positions
    D(clipIdx).pupilSize = clips(clipIdx).pupilSize; % Pupil size
end
%% Total number of clips
N = numClips;

%% Display summary
    fprintf('Loaded data for participant %d, movie %d: %d clips.\n', participantIdx, movieIdx, N);
end