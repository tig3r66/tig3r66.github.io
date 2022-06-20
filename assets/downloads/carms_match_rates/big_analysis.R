library(tidyverse)
library(openxlsx)


urls <- c('https://www.carms.ca/wp-content/uploads/2021/06/2021_r1_tbl2e.xlsx',
          'https://www.carms.ca/wp-content/uploads/2020/05/2020_r1_tbl2e.xlsx',
          'https://www.carms.ca/wp-content/uploads/2019/05/2019_r1_tbl2e.xlsx',
          'https://www.carms.ca/wp-content/uploads/2018/06/r1_tbl2e_2018.xlsx')

df <- as_tibble(read.xlsx(urls[1], startRow = 4))
years <- seq(2021, 2018)

df <- df %>%
  select(School.of.Graduation,
         Current.Year.Matched.Graduates,
         Current.Year.Unmatched.Graduates) %>%
  mutate(total=Current.Year.Matched.Graduates+Current.Year.Unmatched.Graduates,
         matched_perc=Current.Year.Matched.Graduates/total,
         unmatched_perc=Current.Year.Unmatched.Graduates/total) %>%
  rename(school=School.of.Graduation,
         matched=Current.Year.Matched.Graduates,
         unmatched=Current.Year.Unmatched.Graduates)
df$year <- years[1]


for (i in 2:length(years)) {
  if (i %in% seq(1, 2)) {
    temp <- as_tibble(read.xlsx(urls[i], startRow = 4)) 
  } else {
    temp <- as_tibble(read.xlsx(urls[i], startRow = 3)) 
  }
  temp <- temp %>%
    select(School.of.Graduation,
           Current.Year.Matched.Graduates,
           Current.Year.Unmatched.Graduates) %>%
    mutate(total=Current.Year.Matched.Graduates+Current.Year.Unmatched.Graduates,
           matched_perc=Current.Year.Matched.Graduates/total,
           unmatched_perc=Current.Year.Unmatched.Graduates/total) %>%
    rename(school=School.of.Graduation,
           matched=Current.Year.Matched.Graduates,
           unmatched=Current.Year.Unmatched.Graduates)
  temp$year <- years[i]
  df <- rbind(df, temp)
}

df$school[df$school=="Queen’s University"] <- "Queen's University"

schools <- c("Queen's University",
             "University of Toronto",
             "McMaster University",
             "University of Alberta",
             "University of Calgary",
             "University of British Columbia",
             "University of Ottawa")

temp <- filter(df, school %in% schools)

ggplot(temp, aes(year, unmatched_perc*1e2)) +
  # geom_bar(stat='identity') +
  geom_point() +
  geom_line() +
  facet_wrap(~school) +
  theme_linedraw() +
  labs(y='First Iteration Unmatched Rate (%)', x='Year')

ggplot(temp, aes(year, unmatched_perc*1e2, col=school)) +
  geom_point() +
  geom_line() +
  theme_linedraw() +
  labs(y='First Iteration Unmatched Rate (%)', x='Year')
