#--kpk-population-data-----
# ********************************************

# Install packages (if not already installed)
install.packages(c("readxl", "dplyr", "ggplot2", "plotly", "janitor", "DT", "htmlwidgets"))

# Load the libraries----
library(readxl)       # For reading Excel files
library(dplyr)        # For data manipulation
library(ggplot2)      # For static plotting
library(plotly)       # For interactive plotting
library(janitor)      # For cleaning column names
library(DT)           # For interactive tables
library(htmlwidgets)  # For saving interactive plots to HTML



# Load the Excel file (assuming it's in your working directory)----
 df <- read_excel("population_district_wise_kpk.xlsx")
View(df)

# Clean the column names to snake_case for easy access
df <- clean_names(df)

# View first few rows to understand the structure
head(df)

# See column names
colnames(df)

#04- Structure and types of each column----
str(df)

# Summary statistics (mean, min, max, etc.)
summary(df)

# Check for missing values
colSums(is.na(df))




#05-  Summarize the Population by District----
df <- df %>%
  rename(
    district = x1
  )

district_summary <- df %>%
  group_by(district) %>%
  summarise(total_population = sum(population, na.rm = TRUE), .groups = "drop")

df <- df %>% select(-x3)
View(df)

# : Display Interactive Summary Table----
datatable(
  district_summary,
  options = list(pageLength = 15),
  caption = '📌 District-wise Population Summary (KPK)'
)
library(DT)
library(htmlwidgets)

# Create the interactive datatable
district_table <- datatable(
  district_summary,
  options = list(pageLength = 15),
  caption = '📌 District-wise Population Summary (KPK)'
)

# Save the datatable as an HTML file
saveWidget(district_table, "district_summary_table.html", selfcontained = TRUE)





# STEP 6: Identify Top 10 Most Populous Districts----
# ******************************************************
top10 <- district_summary %>%
  arrange(desc(total_population)) %>%
  slice_head(n = 10)
# Save top 10 districts to CSV
write.csv(top10, "top10_populous_districts.csv", row.names = FALSE)

## STEP 7: Static Plot - Top 10 Districts by Population----
library(plotly)
library(htmlwidgets)

# Create ggplot object
p <- ggplot(top10, aes(x = reorder(district, total_population), y = total_population)) +
  geom_col(fill = "#2c7fb8") +
  coord_flip() +
  labs(
    title = "Top 10 Most Populous Districts in KPK",
    subtitle = "Hover to explore values",
    x = "District",
    y = "Population"
  ) +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal(base_size = 14)

# Convert to plotly object
interactive_plot <- ggplotly(p)

# Save as HTML
saveWidget(interactive_plot, "top10_districts_population.html", selfcontained = TRUE)






