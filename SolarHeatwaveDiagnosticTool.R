# Solar–Heat Alignment Diagnostic (India)
# Developed under CapCorPro | Author: Sonya | Year: 2025

# Load required libraries
library(dplyr)
library(readxl)
library(writexl)

# --- HEATWAVE DATA PREP ---

# Load state-level annual heatwave data (2000–2023)
# Source: Indian Meteorological Department (compiled via ENVISTATS)
heatwave_data <- read_excel("data/heatwave_days_2000_2023.xlsx")

heatwave_summary <- heatwave_data %>%
  filter(Year >= 2000 & Year <= 2023) %>%
  group_by(State) %>%
  summarise(
    Average_HW_Days = mean(HW_Days, na.rm = TRUE)
  ) %>%
  arrange(desc(Average_HW_Days)) %>%
  mutate(
    HW_Rank = row_number(),
    Exposure_Score = ntile(Average_HW_Days, 5)  # Quintile-based scoring (5 = highest exposure)
  )

# --- SOLAR DATA PREP ---

# Load cumulative state-level solar capacity data (2017–2023)
# Source: Ministry of New and Renewable Energy (MNRE)
solar_data <- read_excel("data/solar_capacity_2017_2023.xlsx")

solar_summary <- solar_data %>%
  group_by(State) %>%
  summarise(
    Total_Solar_Capacity = sum(Solar_Capacity, na.rm = TRUE)
  ) %>%
  arrange(desc(Total_Solar_Capacity)) %>%
  mutate(
    Solar_Rank = row_number(),
    Solar_Score = ntile(Total_Solar_Capacity, 5)  # Quintile-based scoring (5 = highest rollout)
  )

# --- ALIGNMENT DIAGNOSTIC ---

# Merge datasets and compute Gap Score
alignment_df <- heatwave_summary %>%
  left_join(solar_summary, by = "State") %>%
  mutate(
    Gap_Score = Exposure_Score - Solar_Score
  )

# Classify states into infrastructure–risk typologies
alignment_df <- alignment_df %>%
  mutate(
    Typology = case_when(
      Exposure_Score >= 4 & Solar_Score <= 2 ~ "Overexposed + Underserved",
      Exposure_Score >= 4 & Solar_Score >= 4 ~ "Overexposed + Performing",
      Exposure_Score <= 2 & Solar_Score >= 4 ~ "Underexposed + Overserved",
      Exposure_Score <= 2 & Solar_Score <= 2 ~ "Underexposed + Underserved",
      TRUE ~ "Marginal Misalignment"
    )
  )

# --- EXPORT ---

# Write final output to Excel
write_xlsx(alignment_df, path = "outputs/HW_Solar_Alignment_Scores.xlsx")
