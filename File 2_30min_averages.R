# ============================================================
# 02_30min_averages.R
# Calculate 30-minute averages of environmental measurements
# ============================================================

library(dplyr)
library(lubridate)

# Input data: df
# Required columns:
# Deployment_ID, Region, Ecosystem_Type, Latitude, Longitude,
# DateTimeSolar2, Temperature, O2sat, O2mgL, pHtot, pHtot_25C
#
# DateTimeSolar2 must be in POSIXct date-time format.

# 1. Assign measurements to 30-minute intervals
# 2. Calculate averages separately for each day and deployment

df <- df %>%
  mutate(
    Date = as.Date(DateTimeSolar2),
    TimeWindow = floor_date(DateTimeSolar2, unit = "30 minutes")
  ) %>%
  group_by(
    Deployment_ID,
    Region,
    Ecosystem_Type,
    Latitude,
    Longitude,
    Date,
    TimeWindow
  ) %>%
  summarise(
    Temperature = mean(Temperature, na.rm = TRUE),
    O2sat = mean(O2sat, na.rm = TRUE),
    O2mgL = mean(O2mgL, na.rm = TRUE),
    pHtot = mean(pHtot, na.rm = TRUE),
    pHtot_25C = mean(pHtot_25C, na.rm = TRUE),
    .groups = "drop"
  )
