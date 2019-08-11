# Library Declaration
library(shiny)

suppressPackageStartupMessages(library(caret))
suppressPackageStartupMessages(library(rpart))
suppressPackageStartupMessages(library(e1071))
suppressPackageStartupMessages(library(rattle))
suppressPackageStartupMessages(library(rpart.plot))

# Data Loading
data_tumor <- read.csv('breast_cancer_dataset.csv')

# Data Partitioning
inTrain <- createDataPartition(y=data_tumor$class, p = 0.7, list=FALSE)
training <- data_tumor[inTrain,]
testing <- data_tumor[-inTrain,]

# Data Fitting
tumor_model <- train(class ~ ., method="rpart", data=data_tumor)
rpart_imp <- varImp(tumor_model, scale = FALSE)

# Shiny Server
shinyServer(
  function(input, output) {
    output$TumorPrediction<-renderText({
      userInput <-data.frame(input$id1,input$id2,input$id3,input$id4,input$id5,
                             input$id6,input$id7,input$id8,input$id9)
      names(userInput)<-c("clump_thickness","uniformity_of_cell_size","uniformity_of_cell_shape",
                          "marginal_adhesion","single_epithelial_cell_size","bare_nuclei",
                          "bland_chromatin","normal_nucleoli","mitosis")
      levels(data_tumor$class)[predict(tumor_model,newdata=userInput)]
    })
    output$tree <- renderPlot({fancyRpartPlot(tumor_model$finalModel)
    })
    output$imp <- renderPlot({plot(rpart_imp, top = 5)
    })
  }
)