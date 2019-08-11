library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Breast Cancer Tumor Prediction"),  
    sidebarPanel(
      helpText("This application is a predictor for the type of tumor on a suspected breast cancer patient. 
               In addition, the classification tree of the model is shown and the top 5 features that determines
               the classification of the tumor.
               For the user guide, click on the link below:"),
      p(strong("Documentation:", style="color:blue"), a("User Guide",href="http://rpubs.com/")),
      h3('Input'),
      numericInput('id1', strong('Clump Thickness'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id2', strong('Uniformity of Cell Size'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id3', strong('Uniformity of Cell Shape'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id4', strong('Marginal Adhesion'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id5', strong('Single Epithelial Cell Size'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id6', strong('Bare Nuclei'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id7', strong('Bland Chromatin'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id8', strong('Normal Nucleoli'), value = 1, min = 1, max = 10, step = 1),
      numericInput('id9', strong('Mitosis'), value = 1, min = 1, max = 10, step = 1),
      submitButton('Submit')
      ),
    mainPanel(
      h3('Prediction Output'),
      h4('Predicted species'),
      verbatimTextOutput("TumorPrediction"),
      h3('Classification Tree'),
      h4('Modeled Classification Tree for Tumor Prediction'),
      plotOutput('tree'),
      h3('Feature Importance'),
      h4('Top 5 Features'),
      plotOutput('imp')
    )
    )
  )