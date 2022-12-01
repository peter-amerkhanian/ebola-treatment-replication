library(tidyverse)
library(readxl)
library(ggplot2)
library(patchwork)

library(ggthemr)
ggthemr("dust")

plot_data <- read_excel("community_care.xlsx", sheet = "plots")

plot_data$treat <- as.factor(plot_data$treat)
plot_data$week <- as.Date(plot_data$week)

line_color <- "black"
line_width <- .7
line_alpha <- .5
line_type = "longdash"

treatment_date <- as.Date("10/15/2014", "%m/%d/%Y")

p1 <-
  ggplot(data = plot_data, aes(x = week, y = total, group = treat)) +
  geom_line(aes(color = treat)) +
  geom_vline(
    xintercept = treatment_date,
    size = line_width,
    color = line_color,
    alpha = line_alpha,
    linetype = line_type
  )

p2 <-
  ggplot(data = plot_data, aes(x = week, y = confirmed, group = treat)) +
  geom_line(aes(color = treat)) +
  geom_vline(
    xintercept = treatment_date,
    size = line_width,
    color = line_color,
    alpha = line_alpha,
    linetype = line_type
  )

p3 <-
  ggplot(data = plot_data, aes(x = week, y = log_total, group = treat)) +
  geom_line(aes(color = treat)) +
  geom_vline(
    xintercept = treatment_date,
    size = line_width,
    color = line_color,
    alpha = line_alpha,
    linetype = line_type
  )


p4 <-
  ggplot(data = plot_data, aes(x = week, y = log_conf, group = treat)) +
  geom_line(aes(color = treat)) +
  geom_vline(
    xintercept = treatment_date,
    size = line_width,
    color = line_color,
    alpha = line_alpha,
    linetype = line_type
  )

patch <-  p1 + theme_bw() + p2 + theme_bw() + p3 + theme_bw() + p4 + theme_bw()

final <- patch + plot_annotation(
  title = 'Community Care Center Impacts',
  caption = paste(
    'Note: vertical lines represent date of treatment:',
    treatment_date
  )
)

final

ggsave(
  'Care_Center_Impacts.png',
  final,
  limitsize = FALSE,
  width = 10,
  height = 6,
  units = "in"
)
