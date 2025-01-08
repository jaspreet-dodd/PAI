%% Computing clip duration times (in ms) for movies 1 - 10 
%  The following script computes clip duration (in ms) for movies 1 - 10.
%  This script uses one subject to compute clip duration times. These clip
%  durations will later be used to index the MovAlign structure.

%% Intialize structures needed for input 
clipTimes = vidInfo.clipTimes; %1x20 cell containing clipTimes in frames
ftimes = FV{1,1}.ftimes;       %10x1 cell containing frame and corresponding ms values for participant 1
viewingOrder = [1, 5, 4, 2, 3, 6, 8, 7, 9, 10]; % Pseudorandomized order, movie order for participant 1
numMovies = 10;                %10 movies to analyze
%% Preallocate a cell array to store clip durations (ms) for each movie 
clipDurations = cell(numMovies, 1);
%% Loop through 1 - 10 movies 
for idx = 1:numMovies
    % Get actual movie index (bc sequential order in VidInfo)
    movieIdx = viewingOrder(idx);

    % Find clip change frame indices for the current movie
    clipFrames = clipTimes{1,movieIdx}; %1x16-17 array of frame indices

    % Find the corresponding frame-ms values for the current movie
    frameData = ftimes{idx};       %16-17x2 array in [frames,ms]
    frames = frameData(:, 1);           %Frame numbers
    msTimes = frameData(:, 2);          %Corresponding ms times 

    % Match clipFrames with frames in ftimes times to find corresponding ms values
    [~, loc] = ismember(clipFrames, frames); %Indices of clipFrames in frames
    clipMsTimes = msTimes(loc);              %Retrieve corresponding ms values

    % Calculate clip duration for current movie (diff between consecutive clip times)
    durations = diff(clipMsTimes);           %Duration in ms

    % Store clip durations for current movie
    clipDurations{movieIdx} = durations;     %Store as a row vector 
end 
%% Output: cell array where each cell contains the clip durations for a movie
disp('Clip durations for all movies (based on sequential order):');
disp(clipDurations);
