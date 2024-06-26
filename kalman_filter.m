

close all
clear

m = Model.fromFile("linear_3eq.matlab", linear=true, growth=true, std=0);

parameters = jsondecode(fileread("data_files/parameters.json"));

m = assign(m, parameters);
m = solve(m);
m = steady(m);

dates = jsondecode(fileread("data_files/dates.json"));

start_filt = Dater.fromIsoString(4, dates.start_filt);
end_filt = Dater.fromIsoString(4, dates.end_filt);
filt_span = start_filt : end_filt;

obs_db = databank.fromSheet( ...
    "data_files/obs_db.csv" ...
    , includeComments=false ...
)

f1 = kalmanFilter( ...
    m, obs_db, filt_span ...
    , relative=false ...
    , output="pred,filter,smooth" ...
);

s1 = f1.Smooth.Mean;
t1 = f1.Smooth.Std;

f2 = kalmanFilter( ...
    m, obs_db, filt_span ...
    , relative=false ...
    , output="pred,filter,smooth" ...
    , override=obs_db ...
);

s2 = f2.Smooth.Mean;
t2 = f2.Smooth.Std;

databank.toSheet( ...
    s2 ...
    , "data_files/matlab_smooth_med.csv" ...
    , includeComments=false ...
);

databank.toSheet( ...
    t2 ...
    , "data_files/matlab_smooth_std.csv" ...
    , includeComments=false ...
);

