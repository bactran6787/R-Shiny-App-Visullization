#Assignment 1 - Bac Tran
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)
library(vcd)
library(summarytools)
library(DT)
library(MASS)
library(RColorBrewer)
library(seriation)
library(datasets)
library("corrgram")
library(visdat)
library(tidytext)
library(tidyverse)
library(janeaustenr)
library(stringr)
library(reshape2)
library(pls)
library(ggplot2)
library(car)
library(matrixStats) # for calculate RowMedian for each sensor


library(shiny)
library(shinyjs)
library(DT)
library(shinycssloaders)
library(MASS)
library(datasets)
library(wordcloud2)
library(GGally)

dat <- read.csv("Ass1Data.csv", header = TRUE, stringsAsFactors = TRUE)

dat_his <- data.frame(dat[,1], dat[,15:44])

choicesA <- c("Supervisor","Priority","Price","Speed","Duration","Temp","State","Location",
              "Agreed","Class", "Surface")


choicesB <- c("survey1", "survey2", "survey3", "survey4", "survey5",
              "survey6", "survey7", "survey8", "survey9", "survey10",
              "survey11", "survey12", "survey13", "survey14", "survey15",
              "survey16", "survey17", "survey18", "survey19", "survey20",
              "survey21", "survey22", "survey23", "survey24", "survey25",
              "survey26", "survey27", "survey28", "survey29", "survey30", "Y"
)

ChoicesC <- c(choicesB , "median_survey1to10","median_surveyr11to20","median_survey21to30")

choicesA_default <- c("Price","Speed", "Temp")

choicesB_default <- c("Y","survey1", "survey11", "survey21")

choicesC_default <- c("survey4", "survey5","survey6","survey1", "Y")

choicesD_default <- c("Price","Speed")

choicesE_default <- c("median_survey1to10","median_surveyr11to20","median_survey21to30", "Y")


