library(tidyverse)

# 2021
df <- as_tibble(read_csv('/Users/eddieguo/Desktop/University/Undergraduate/Medicine/carms_match_rate_2021.csv'))
barplot(df$Unmatched_Percent, name=df$School,
        ylab="First Iteration Unmatched 2021 (%)",
        col="#69b3a2",
        ylim=c(0, 7))

# 2020
df20 <- as_tibble(read_csv('/Users/eddieguo/Desktop/University/Undergraduate/Medicine/carms_match_rate_2020.csv'))
barplot(df20$Unmatched_Percent, name=df20$School,
        ylab="First Iteration Unmatched 2020 (%)",
        col="#69b3a2",
        ylim=c(0, 8))

# 2019
df19 <- as_tibble(read_csv('/Users/eddieguo/Desktop/University/Undergraduate/Medicine/carms_match_rate_2019.csv'))
barplot(df19$Unmatched_Percent, name=df19$School,
        ylab="First Iteration Unmatched 2019 (%)",
        col="#69b3a2",
        ylim=c(0, 15))

# 2018
df18 <- as_tibble(read_csv('/Users/eddieguo/Desktop/University/Undergraduate/Medicine/carms_match_rate_2018.csv'))
barplot(df18$Unmatched_Percent, name=df18$School,
        ylab="First Iteration Unmatched 2018 (%)",
        col="#69b3a2",
        ylim=c(0, 12))

# 2018-2021
dftot <- as_tibble(read_csv('/Users/eddieguo/Desktop/University/Undergraduate/Medicine/carms_match_rate_2018_21.csv'))
barplot(dftot$Unmatched_Percent, name=dftot$School,
        ylab="First Iteration Unmatched 2018-21 (%)",
        col="#69b3a2",
        ylim=c(0, 12))
