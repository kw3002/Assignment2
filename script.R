library(tidyverse)

library(janitor)

bankrate_data <- read_csv("bankrate_data.csv")

bankrate_clean_names <- clean_names(bankrate_data)

bankrate_selected <- select(bankrate_clean_names, year, monthly_fee_for_interest_accounts, monthly_fee_for_non_interest_accounts, annual_overdraft_fee)

bankrate_filtered <- filter(bankrate_selected, monthly_fee_for_interest_accounts> 0, monthly_fee_for_non_interest_accounts> 0, annual_overdraft_fee> 0)

bankrate_mutate1 <- mutate(bankrate_filtered, average_annual_cost_of_maintaining_non_interest_accounts  = monthly_fee_for_non_interest_accounts*12)

bankrate_mutate2 <- mutate(bankrate_mutate1, average_annual_cost_of_maintaining_interest_accounts  = monthly_fee_for_interest_accounts*12)

bankrate_mutate3 <- mutate(bankrate_mutate2, average_annual_cost_of_using_non_interest_accounts  = monthly_fee_for_non_interest_accounts*12+annual_overdraft_fee)

bankrate_mutate4 <- mutate(bankrate_mutate3, average_annual_cost_of_using_interest_accounts  = monthly_fee_for_interest_accounts*12+annual_overdraft_fee)

summarise(bankrate_mutate4, mean_average_annual_cost_of_maintaining_non_interest_accounts = mean(average_annual_cost_of_maintaining_non_interest_accounts))

summarise(bankrate_mutate4, mean_average_annual_cost_of_maintaining_interest_accounts = mean(average_annual_cost_of_maintaining_interest_accounts))

summarise(bankrate_mutate4, mean_average_annual_cost_of_using_non_interest_accounts = mean(average_annual_cost_of_using_non_interest_accounts))

summarise(bankrate_mutate4, mean_average_annual_cost_of_using_interest_accounts = mean(average_annual_cost_of_using_interest_accounts))

df <- group_by(bankrate_mutate4, year)

summarise(bankrate_mutate4, mean_average_annual_cost_of_using_non_interest_accounts = mean(average_annual_cost_of_using_non_interest_accounts))

summarise(bankrate_mutate4, mean_average_annual_cost_of_using_interest_accounts = mean(average_annual_cost_of_using_interest_accounts))

df

write_csv(df, "bankfee_data.csv")
