#Assignment 1 - Bac Tran
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

shinyServer(function(input, output, session) {
  
    output$Summary1 <- renderPrint({
      str(dat)  #summary1 
    })
      
    output$Summary2 <- renderUI({
      Data <- dat
      summary <- summarytools::dfSummary(Data, graph.magnif = 1.5)
      summarytools::view(summary, 
                         method = 'render',
                         report.title = NA,
                         headings = FALSE,
                         bootstrap.css = FALSE,
                         footnote = NA,
                         max.tbl.height = 600,
                         collapse = TRUE,
                         silent = TRUE
        )
      })
    
    output$Rawdata <- DT::renderDataTable({
      DT::datatable(data = as.data.frame(dat))
    })
    
    output$Mosaic <- renderPlot({
      formula <- as.formula(paste("~",paste(input$VariablesA, collapse = " + ")))
      vcd::mosaic(formula, data = dat,
                  main = "MosaicPlot of Categorical data", shade = TRUE, legend = TRUE)
    })
    
    output$Boxplot <- renderPlot({
      data <- as.matrix(dat[,c(1, 15:44)])
      data <- scale(data, center = input$standardise, scale = input$standardise)
      car::Boxplot(y = data, ylab = NA, use.cols = TRUE, notch = FALSE, varwidth = FALSE,  
                   horizontal = FALSE, outline = input$outliers, 
                   col = brewer.pal(n = dim(airquality)[2], name = "RdBu"),
                   range = input$range, main = "Boxplots of Numeric data", 
                   id = ifelse(input$outliers, list(n = Inf, location = "avoid"), FALSE))
    })
    
    output$Corrgram <- renderPlot({
      data <- as.matrix(dat[,c(1, 15:44)])
      corrgram(data, 
               order = input$Group, 
               abs = input$abs, 
               cor.method = input$CorrMeth,
               text.panel = panel.txt,
               main = "Correlation of Numeric data")
    })
    
    output$Risingchart <- renderPlot({
      cols <- c(input$VariablesC)
      data <- as.matrix(dat[,cols])
      for (col in 1:ncol(data)) {
        data[,col] <- data[order(data[,col]),col] #sort each column in ascending order
      }
      
      # scale so they can be graphed with a shared Y axis
      data <- scale(x = data, center = input$standardise_ris, scale = input$standardise_ris)  
      
      mypalette <- rainbow(ncol(data))
      matplot(y = data, type = "l", xlab = "Observations", ylab = "Values", 
              lty = 1, lwd = 1, col = mypalette, 
              main = "Rising Order charts of Numeric data")
      legend(legend = colnames(data), x = "topleft", y = "top", lty = 1, lwd = 1, 
             col = mypalette, ncol = round(ncol(data)^0.3))
    })
    
    output$Histogram <- renderPlot({
      ggplot2::ggplot(data = dat[-c(2:14)], mapping = aes(x = !!input$VariableG), main = "Histogram of Numeric data"  ) +
        geom_histogram(bins = input$bins) +
        labs(title = "Histogram of a numeric variable") 
      
    })
    
    output$Missing <- renderPlot({
      visdat::vis_miss(dat, cluster = input$cluster) +
        labs(title = "Missingness of Assignment 1 data")
    })
    
    output$MixedPairs <- renderPlot({
      median_survey1to10 <- rowMedians(as.matrix(dat[,15:24]))
      median_survey11to20 <- rowMedians(as.matrix(dat[,25:34]))
      median_survey21to30 <- rowMedians(as.matrix(dat[,35:44]))
      cat_cols <- c(input$VariablesD)
      colour_1 <- c(input$VariablesE)
      num_cols <- c(input$VariablesF)
      data_num <- data.frame( dat[,15:44], dat$Y, median_survey1to10, median_survey11to20, median_survey21to30)
      colnames(data_num) <- c(ChoicesC)
      data_mixed <- data.frame(dat[,cat_cols], data_num[,num_cols])
      GGally::ggpairs(data = data_mixed,  mapping = ggplot2::aes(colour = dat[,colour_1]), 
            columnLabels = c(cat_cols, num_cols), 
            title = "Pairs of Assignment 1 data")
    })
    
    output$MatPlot <- renderPlot({
      cols <- c(input$VariablesB) # choose the numeric columns
      numData <- scale(dat[,cols], center = input$Center, scale = input$Scale) 
      matplot(numData, type = "l", col = rainbow(ncol(numData)), xlab = "Observations in sequence", ylab = "Value",
              main = "Mathplots of Numeric data")
    })
    
})
