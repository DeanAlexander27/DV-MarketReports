library(dplyr) # untuk transformasi data
library(plotly) # untuk membuat plot menjadi interaktif
library(glue) # untuk custom informasi saat plot interaktif
library(scales) # untuk custom keterangan axis atau lainnya
library(ggpubr) # untuk export plot
library(readr) # untuk membaca data
library(tidyr) # untuk cleansing data
library(readxl)
library(purrr)
library(lubridate)
library(stringr)
library(DT)
library(imputeTS)
library(here)

options(dplyr.summarise.inform = FALSE)

# READ DATA
dataset1 <- "dataset.xlsx"
dataset1 <- excel_sheets(dataset1) %>% 
  set_names() %>% 
  map_dfr(~ read_excel(dataset1, sheet = .x)) %>% 
  mutate(`Key Figures` = as.factor(`Key Figures`)) %>% 
  mutate(`Main Dealer...1` = as.factor(`Main Dealer...1`)) %>% 
  mutate(`Main Dealer...2` = as.factor(`Main Dealer...2`)) %>% 
  mutate(`Type` = as.factor(`Type`)) %>% 
  mutate(Category = as.factor(Category)) %>% 
  rename(main_dealer = `Main Dealer...2`) %>% 
  rename(key_figures = `Key Figures`) %>% 
  rename(jan_2021 = `- JAN 2021`) %>% 
  rename(feb_2021 = `- FEB 2021`) %>% 
  rename(mar_2021 = `- MAR 2021`) %>% 
  rename(apr_2021 = `- APR 2021`) %>% 
  rename(may_2021 = `- MAY 2021`) %>% 
  rename(jun_2021 = `- JUN 2021`) %>% 
  rename(jul_2021 = `- JUL 2021`) %>% 
  rename(aug_2021 = `- AUG 2021`) %>% 
  rename(sep_2021 = `- SEP 2021`) %>% 
  rename(oct_2021 = `- OCT 2021`) %>% 
  rename(nov_2021 = `- NOV 2021`) %>% 
  rename(dec_2021 = `- DEC 2021`) %>%
  rename(jan_2022 = `- JAN 2022`) %>%
  rename(feb_2022 = `- FEB 2022`) %>%
  rename(mar_2022 = `- MAR 2022`) %>%
  rename(apr_2022 = `- APR 2022`) %>%
  rename(may_2022 = `- MAY 2022`) %>%
  rename(jun_2022 = `- JUN 2022`) %>%
  rename(jul_2022 = `- JUL 2022`) %>% 
  rename(jan_2020 = `- JAN 2020`) %>%
  rename(feb_2020 = `- FEB 2020`) %>% 
  rename(mar_2020 = `- MAR 2020`) %>% 
  rename(apr_2020 = `- APR 2020`) %>%
  rename(may_2020 = `- MAY 2020`) %>%
  rename(jun_2020 = `- JUN 2020`) %>%
  rename(jul_2020 = `- JUL 2020`) %>%
  rename(aug_2020 = `- AUG 2020`) %>%
  rename(sep_2020 = `- SEP 2020`) %>%
  rename(oct_2020 = `- OCT 2020`) %>%
  rename(nov_2020 = `- NOV 2020`) %>%
  rename(dec_2020 = `- DEC 2020`) %>% 
  rename(jan_2019 = `- JAN 2019`) %>%
  rename(feb_2019 = `- FEB 2019`) %>% 
  rename(mar_2019 = `- MAR 2019`) %>% 
  rename(apr_2019 = `- APR 2019`) %>%
  rename(may_2019 = `- MAY 2019`) %>%
  rename(jun_2019 = `- JUN 2019`) %>%
  rename(jul_2019 = `- JUL 2019`) %>%
  rename(aug_2019 = `- AUG 2019`) %>%
  rename(sep_2019 = `- SEP 2019`) %>%
  rename(oct_2019 = `- OCT 2019`) %>%
  rename(nov_2019 = `- NOV 2019`) %>%
  rename(dec_2019 = `- DEC 2019`) %>% 
  pivot_longer(cols = c("jan_2021" , "feb_2021","mar_2021","apr_2021","may_2021","jun_2021","jul_2021","aug_2021","sep_2021",
                        "oct_2021","nov_2021","dec_2021","jan_2022","feb_2022","mar_2022","apr_2022","may_2022","jun_2022","jul_2022","jan_2020","feb_2020","mar_2020","apr_2020","may_2020","jun_2020","jul_2020",
                        "aug_2020","sep_2020","oct_2020","nov_2020","dec_2020","jan_2019","feb_2019","mar_2019","apr_2019","may_2019","jun_2019","jul_2019",
                        "aug_2019","sep_2019","oct_2019","nov_2019","dec_2019"),
               names_to= "Tahun",
               values_to = "value") %>% 
  mutate_all(funs(replace(., is.na(.), 0))) %>% 
  mutate(Tahun = parse_date_time(Tahun, orders = "BY"), 
         year = year(Tahun),
         month = month(Tahun, label = T)) %>% 
  select(-c(`Main Dealer...1`)) %>% 
  mutate(Tahun = as.factor(Tahun)) %>% 
  mutate(year = as.factor(year)) %>% 
  mutate(month= as.factor(month))

glimpse(dataset1)
colSums(is.na(dataset1))


# Theme
theme_algoritma <- theme(legend.key = element_rect(fill="black"),
                         legend.background = element_rect(color="white", fill="#263238"),
                         plot.subtitle = element_text(size=6, color="white"),
                         panel.background = element_rect(fill="white"),
                         panel.border = element_rect(fill=NA),
                         panel.grid.minor.x = element_blank(),
                         panel.grid.major.x = element_line(color="darkgrey", linetype=2),
                         panel.grid.major.y = element_line(color="darkgrey", linetype=2),
                         panel.grid.minor.y = element_blank(),
                         plot.background = element_rect(fill="#263238"),
                         text = element_text(color="white"),
                         axis.text = element_text(color="white"))
