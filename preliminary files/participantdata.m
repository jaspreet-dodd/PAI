%% Participant data extraction from MovAlign structure (movies 1 - 10)
%  This script extracts clip aligned data for a single participant for
%  movies 1 - 10. This script depends on clipduration.m and
%  movalignindices.m

%% Intialize and configuration 
participantIdx = 1; % Change this value to specify the specific participant index (1 = subj1, etc)
outputFolder = 'C:\Users\Jaspreet\Desktop\output\subj1'; % This folder should already exist. cd to match where you'd like files to go. 
numMovies = 10; % How many movies should be processed
%% Loop through all movies to make associated .mat file 
for movieIdx = 1:numMovies
    % First, create movie field and clip boundary structures
    movieField = sprintf('mov%d', movieIdx); % Creates mov(n) fields; e.g., mov1, mov2... etc
    clipBoundaries = movAlignIndices.(movieField).clipBoundaries; % Start and end indices
    numClips = length(clipBoundaries) - 1; % Number of clips 

    % Initialize clips structure
    clip = struct();

    % Data from MovAlign 
    eyeXPos = MovAlign.EYExdeg.(movieField); % eye x positions in degrees
    eyeYPos = MovAlign.EYEydeg.(movieField); % eye y positions in degrees
    pupilSize = MovAlign.PUP.(movieField); % eye pupil size in PIXELS SQUARED 
    totalSamples = size(eyeXPos, 2); % Total time points (i.e., amount of columns)

    % Check to see if totalSamples matches the last clip boundary
    assert(clipBoundaries(end) - 1 <= totalSamples, ...
        'Clip boundaries exceed available samples for movie %d.', movieIdx);

    % Extract data from each clip 
    for clipIdx = 1:numClips
        startIdx = clipBoundaries(clipIdx); % Start of clip 
        endIdx = clipBoundaries(clipIdx + 1) - 1; % End of clip 

        % Put information in clip structure
        clip(clipIdx).time = (startIdx-1)*2:2:(endIdx-1)*2; % Time points (ms)
        clip(clipIdx).eyeX = eyeXPos(participantIdx, startIdx:endIdx)';
        clip(clipIdx).eyeY = eyeYPos(participantIdx, startIdx:endIdx)';
        clip(clipIdx).pupilSize = pupilSize(participantIdx, startIdx:endIdx)';
    end

    % Save clip structure to a .mat file
    outputFile = fullfile(outputFolder, sprintf('subj%d_movie%d.mat', participantIdx, movieIdx));
    save(outputFile, 'clip');

    % Check
    fprintf('Saved data for participant %d, movie %d to %s\n', participantIdx, movieIdx, outputFile);
end
   
%% End 
fprintf('Data extraction for participant %d and saving is complete. Good job!\n', participantIdx);