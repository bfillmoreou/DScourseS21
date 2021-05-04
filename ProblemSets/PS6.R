# Load in data sets

path <- '/Users/Benjamin Fillmore/Documents/Courses/data_science_for_economists/Data'


prem <- read.csv(paste(path, '/gen_ref_chelsea_prem', sep=''))
ucl  <- read.csv(paste(path, '/gen_ref_chelsea_ucl', sep=''))
efl  <- read.csv(paste(path, '/gen_ref_chelsea_efl', sep=''))
fa   <- read.csv(paste(path, '/gen_ref_chelsea_fa', sep=''))