%% Computing MovAlign indices for movies 1 - 10 
%  This script computes the valies to index clip-specific data in MovAlign
%  structure. This script depends on output from clipduration.m -
%  calculates clipduration (in ms) based on participant 1 data. 
%
% Outputs:
% This script creates a variable called movAlignIndices which is a
%  structure containing 10 fields (one for each movie). Within a specific
%  movie field, clipBoundaries is a vector with each element representing
%  the start index of a clip (i.e., an end of a current clip is one less
%  than the start of the next clip). 
%
% Example:
% To index a clip in movie 1, use movAlignindices.mov1.clipBoundaries(n) as
% the start index and clipBoundaries(n+1) - 1 as the end index. 

%% Initialize output structure
movAlignIndices = struct();

%% Loop through all movies in clipDurations structure
numMovies = length(clipDurations); % Determine number of movies (i.e., 10)

for movieIdx = 1:numMovies
    % First, store all clip durations for the current movie
    clipDurationsMs = clipDurations{movieIdx}; % Clip durations in ms

    % Convert durations (in ms) to indices (based on 2 ms sampling rate)
    clipIndices = round(clipDurationsMs / 2); % Convert to indices; rounded to deal with odd numbers

    % Last clip calculation
    movieField = sprintf('mov%d', movieIdx); % Field for the current movie
    totalSamples = size(MovAlign.EYExp.(movieField), 2); % Total columns (or samples) in MovAlign 
    lastClipLength = totalSamples - sum(clipIndices);
    clipIndices = [clipIndices; lastClipLength]; % Append last clip duration (remaining samples)

    % Compute cumulative clip boundaries (start and end indices)
    clipBoundaries = [1; cumsum(clipIndices)]; % Include start index for first clip
    
    % Store indices in the output structure
    movAlignIndices.(movieField) = struct();
    movAlignIndices.(movieField).clipBoundaries = clipBoundaries; % Start and end indices
end

%% Output structure
disp('MovAlign indices:');
disp(movAlignIndices);
disp('MovAlign indices are successfully calculated! Woohoo!')