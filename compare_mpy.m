
close all
clear

ms = databank.fromSheet( ...
    "data_files/matlab_smooth_med.csv" ...
    , includeComments=false ...
);

mt = databank.fromSheet( ...
    "data_files/matlab_smooth_std.csv" ...
    , includeComments=false ...
);

ps = databank.fromSheet( ...
    "data_files/python_smooth_med.csv" ...
    , includeComments=false ...
);

pt = databank.fromSheet( ...
    "data_files/python_smooth_std.csv" ...
    , includeComments=false ...
);

maxabs(ps, ms)

maxabs(pt, mt)


