#Program to plot sensitivity and specificity of BMTagger and Deconseq
library(ggplot2)
library(dplyr)
require(grid)
require(gridExtra)
library(cowplot)

#read in data
setwd("Documents/Research/Mills_Lab/metasim_profiles/")
dat <- read.table("metasim_summary_forR.txt", header = T)
#####################
### Overall Stats ###
#####################
#use dplyr to get overall stats
soft_summary <- dat %>% # the names of the new data frame and the data frame to be summarised
  group_by_("software") %>%   # the grouping variable
  summarise(mean_sens = mean(sensitivity),  # calculates the mean of each group
            sd_sens = sd(sensitivity), # calculates the standard deviation of each group
            n_sens = n(),  # calculates the sample size per group
            SE_sens = sd(sensitivity)/sqrt(n()), # calculates the standard error of each group
            mean_spec = mean(specificity),  # calculates the mean of each group
            sd_spec = sd(specificity), # calculates the standard deviation of each group
            n_spec = n(),  # calculates the sample size per group
            SE_spec = sd(specificity)/sqrt(n()),
            mean_accu = mean(accuracy),  # calculates the mean of each group
            sd_accu = sd(accuracy), # calculates the standard deviation of each group
            n_accu = n(),  # calculates the sample size per group
            SE_accu = sd(accuracy)/sqrt(n()))
           

###################
### Sensitivity ###
###################
#summarize data for SE bar based off human level
sens_summary <- dat %>% # the names of the new data frame and the data frame to be summarised
  group_by_(.dots=c("software", "human_level")) %>%   # the grouping variable
  summarise(mean_sens = mean(sensitivity),  # calculates the mean of each group
            sd_sens = sd(sensitivity), # calculates the standard deviation of each group
            n_sens = n(),  # calculates the sample size per group
            SE_sens = sd(sensitivity)/sqrt(n())) # calculates the standard error of each group
#create plot and plot
sens_plot <- ggplot(sens_summary, aes(factor(software), mean_sens, fill=human_level)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar(aes(ymin=mean_sens-SE_sens, ymax=mean_sens+SE_sens), position = "dodge") +
  coord_cartesian(ylim = c(0.94, 0.95)) +
  labs(x = NULL, y = "Sensitivity ± SE") +
  guides(fill=FALSE)
#print(sens_plot + labs(y="Sensitivity ± SE", x = "Software") )



###################
### Specificity ###
###################
#summarize data for SE bar
spec_summary <- dat %>% # the names of the new data frame and the data frame to be summarised
  group_by_(.dots=c("software", "human_level")) %>%   # the grouping variable
  summarise(mean_spec = mean(specificity),  # calculates the mean of each group
            sd_spec = sd(specificity), # calculates the standard deviation of each group
            n_spec = n(),  # calculates the sample size per group
            SE_spec = sd(specificity)/sqrt(n())) # calculates the standard error of each group
#create plot and plot
spec_plot <- ggplot(spec_summary, aes(factor(software), mean_spec, fill=human_level)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar(aes(ymin=mean_spec-SE_spec, ymax=mean_spec+SE_spec), position = "dodge") +
  labs(x = NULL, y = "Specificity ± SE") +
  coord_cartesian(ylim = c(0.94, 1)) +
  guides(fill=FALSE)
#print(spec_plot + labs(y="Specificity ± SE", x = "NULL" )


################
### Accuracy ###
################
#summarize data for SE bar
accu_summary <- dat %>% # the names of the new data frame and the data frame to be summarised
  group_by_(.dots=c("software", "human_level")) %>%   # the grouping variable
  summarise(mean_accu = mean(accuracy),  # calculates the mean of each group
            sd_accu = sd(accuracy), # calculates the standard deviation of each group
            n_accu = n(),  # calculates the sample size per group
            SE_accu = sd(accuracy)/sqrt(n())) # calculates the standard error of each group
#create plot and plot
accu_plot <- ggplot(accu_summary, aes(factor(software), mean_accu, fill=human_level)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar(aes(ymin=mean_accu-SE_accu, ymax = mean_accu+SE_accu), position = "dodge") +
  coord_cartesian(ylim = c(0.95, 0.99)) +
  labs(x = NULL, y = "Accuracy ± SE") +
  guides(fill=guide_legend(title="Human Cont Level"))
#print(accu_plot + labs(y="Accuracy ± SE", x = "NULL" )

################
### Plotting ###
################
## Combine all plots 
ggdraw() +
  draw_plot(sens_plot, 0, 0, .275, 1) +
  draw_plot(spec_plot, .275, 0, .255, 1) +
  draw_plot(accu_plot, .530, 0, .47, 1) +
  draw_plot_label(label = c('A', 'B', 'C'), c(0, 0.255, 0.530))

## Overall Plot for BMT vs Decon ##
sens_soft_plot <- ggplot(soft_summary, aes(factor(software), mean_sens, fill=software)) +
  geom_bar(stat="identity", position="dodge", fill=c("mediumpurple", "green3")) +
  geom_errorbar(aes(ymin=mean_sens-SE_sens, ymax=mean_sens+SE_sens), position = "dodge") +
  coord_cartesian(ylim = c(0.94, 0.95)) +
  labs(x = NULL, y = "Sensitivity ± SE") +
  guides(fill=FALSE)
spec_soft_plot <- ggplot(soft_summary, aes(factor(software), mean_spec, fill=software)) +
  geom_bar(stat="identity", position="dodge", fill=c("mediumpurple", "green3")) +
  geom_errorbar(aes(ymin=mean_spec-SE_spec, ymax=mean_spec+SE_spec), position = "dodge") +
  labs(x = NULL, y = "Specificity ± SE") +
  coord_cartesian(ylim = c(0.94, 1)) +
  guides(fill=FALSE)
accu_soft_plot <- ggplot(soft_summary, aes(factor(software), mean_accu, fill=software)) +
  geom_bar(stat="identity", position="dodge") +
  scale_fill_manual(values=c("mediumpurple", "green3")) +
  geom_errorbar(aes(ymin=mean_accu-SE_accu, ymax = mean_accu+SE_accu), position = "dodge") +
  coord_cartesian(ylim = c(0.96, 0.99)) +
  labs(x = NULL, y = "Accuracy ± SE")  +
  guides(label=TRUE, fill=guide_legend(title="Human Cont Level"))
#Plot
ggdraw() +
  draw_plot(sens_soft_plot, 0, 0, .275, 1) +
  draw_plot(spec_soft_plot, .275, 0, .255, 1) +
  draw_plot(accu_soft_plot, .530, 0, .47, 1) +
  draw_plot_label(c("A", "B", "C"), c(0, 0.275, 0.530), size = 15)

