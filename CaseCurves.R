setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


require(dplyr)
require(tigris)
require(sf)
require(covid19nytimes)

# start with national data

# read it in and create a new cases column
require(readr)
national_data <- read_csv("us.csv", col_types = cols(date = col_date(format = "%Y-%m-%d")))
View(us)

national_data$new_cases <- diff(c(0,national_data$cases))

# making a weekly average of daily new cases


# plot it as a column chart
cases_chart <-  ggplot(national data, aes(x = date, y = new_cases)) +
  xlab("date") +
  ylab("Daily cases")
         

# read states data

us_states <- read_csv("us-states.csv", col_types = cols(date = col_date(format = "%Y-%m-%d")))
View(us_states)

