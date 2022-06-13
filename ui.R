#Assignment 1 - Bac Tran
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

 shinyUI(
      fluidPage(
        useShinyjs(),
        titlePanel("Assignment 1 - Bac Tran"),
        tabsetPanel(
          tabPanel("Data Summary",
                tabsetPanel(
                tabPanel("Summary",
                         verbatimTextOutput(outputId = "Summary1")),
                tabPanel("Data Frame Summary",
                         htmlOutput(outputId = "Summary2")),
                )),
            
          tabPanel("Raw Data",
                  DT::dataTableOutput(outputId = "Rawdata")),
          
          tabPanel("Categorical - MosaicCharts",
                   selectizeInput(inputId = "VariablesA", 
                                  label = "Choose Categorical Variables to chart:", 
                                  choices = choicesA, multiple = TRUE, 
                                  selected = choicesA_default),
                     plotOutput(outputId = "Mosaic")
                   ),
          
          tabPanel("Numeric - BoxPlots",
                   plotOutput(outputId = "Boxplot"),
                   checkboxInput(inputId = "standardise", 
                                 label = "Show standardized", value = FALSE),
                   checkboxInput(inputId = "outliers", 
                                 label = "Show outliers", value = TRUE),
                   sliderInput(inputId = "range", label = "IQR Multiplier", 
                               min = 0, max = 5, step = 0.1, value = 1.5)
                  ),
          
          tabPanel("Numeric - CorrgramPlots",
                   plotOutput(outputId = "Corrgram"),
                   checkboxInput(inputId = "abs", 
                                 label = "Uses absolute correlation", value = TRUE),
                   selectInput(inputId = "CorrMeth", label = "Correlation method", 
                               choices = c("pearson","spearman","kendall"), 
                               selected = "spearman"),
                   selectInput(inputId = "Group", label = "Grouping method", 
                               choices = list("none" = FALSE,"OLO" = "OLO","GW" = "GW","HC" = "HC"), 
                               selected = "OLO")
                  ),
          
          tabPanel("Numeric - MatPlots",
                   selectizeInput(inputId = "VariablesB", 
                                  label = "Choose Variables to chart:", 
                                  choices = choicesB, multiple = TRUE, 
                                  selected = choicesB_default),
                   checkboxInput(inputId = "Center", label = "Center", value = TRUE),
                   checkboxInput(inputId = "Scale", label = "Scale", value = TRUE),
                   plotOutput(outputId = "MatPlot")
                  ),
          
          tabPanel("Numeric - Risingcharts",
                selectizeInput(inputId = "VariablesC", 
                               label = "Choose Variables to chart: ", 
                               choices = choicesB, multiple = TRUE, 
                               selected = choicesC_default),
                checkboxInput(inputId = "standardise_ris", 
                              label = "Show standardized", value = TRUE),
                plotOutput(outputId = "Risingchart")
          ),
          
          tabPanel("Numeric - Histogramcharts",
                   varSelectInput("VariableG", "Choose Numeric Variable to chart::", dat[-c(2:14)]),
                   sliderInput(inputId = "bins",
                               "Number of bins:",
                               min = 1,
                               max = 50,
                               value = 30),
                   plotOutput(outputId = "Histogram")
                   
          ),
          
          tabPanel("Missingness",
                   plotOutput(outputId = "Missing"),
                   checkboxInput(inputId = "cluster", 
                                 label = "Cluster missingness", value = FALSE),
              
          ),
          
          
          tabPanel("MixedPairs Numeric - Categorical",
                   selectizeInput(inputId = "VariablesD", 
                                  label = "Choose Categorical Variables to chart:", 
                                  choices = choicesA, multiple = TRUE, 
                                  selected = choicesD_default),
                   selectizeInput(inputId = "VariablesF", 
                                  label = "Choose Numeric Variables to chart:", 
                                  choices = ChoicesC, multiple = TRUE, 
                                  selected = choicesE_default),
                   selectizeInput(inputId = "VariablesE", 
                                  label = "Choose Categorical Variable to colour:", 
                                  choices = choicesA, multiple = FALSE, 
                                  selected = "Speed"),
                   p("median_survey1to10 represents the Row Medians of group survey 1 to survey 10"),
                   p("median_survey11to20 represents the Row Medians of group survey 11 to survey 20"),
                   p("median_survey21to30 represents the Row Medians of group survey 21 to survey 30"),  
                   plotOutput(outputId = "MixedPairs")
          )
          
)))