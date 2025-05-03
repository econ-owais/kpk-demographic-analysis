# important note:
"To view the  graphs, it's in the HTML form so simply click the download button at the top right of the GitHub page."
# 📊 Project Overview-

 This project analyzes district-wise population data from Khyber Pakhtunkhwa (KPK), Pakistan. I explore demographic patterns across the province using interactive plots and data tables.

📂 Dataset
{r
Copy
Edit
# Load the Excel file 
data <- read_excel("population_district_wise_kpk.xlsx")
datatable(head(data), options = list(pageLength = 5), caption = "Sample of the Dataset")
📈 Interactive Visualizations
🏙️ Population by District
{r
Copy
Edit
plot_data <- data %>%
  arrange(desc(Population)) %>%
  mutate(District = factor(District, levels = unique(District)))

p <- ggplot(plot_data, aes(x = District, y = Population, text = paste("District:", District, "<br>Population:", Population))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Population by District in KPK", x = "", y = "Population")

ggplotly(p, tooltip = "text")
🌍 Map Visualization (Optional if coordinates available)
(Can be added using leaflet if district coordinates exist)

📌 Insights
The most populous districts are likely to be Peshawar, Mardan, etc.

The population varies significantly between urban and rural districts.

This data can support regional planning and resource allocation.

📦 Packages Used
readxl, tidyverse – Data wrangling

plotly – Interactive plots

DT – Interactive data tables

rmarkdown – To render the README

🧠 Author
Owais Ali Shah
Economics  graduate | Data Analyst
# contact
owais.ali.shah.econ@gmail.com
