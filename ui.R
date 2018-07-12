library(shiny)
library(ROCR)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(party)
library(partykit)
library(tree)
library(e1071)
library(xtable)
library(randomForest)
library(shinythemes)
shinyUI(
  fluidPage(theme=shinytheme("readable"),
            titlePanel(title=h3("Malware classification",align="center")),
            shinythemes::themeSelector(),
    
      sidebarLayout(
        sidebarPanel(
          actionButton("j48",label="J48"),
          actionButton("svm",label = "Support Vector Machine"),
          actionButton("dtree",label = "Randomforest")
        
        
        ),
        mainPanel(
        tabsetPanel(type = "tab",
                     tabPanel("Summary",verbatimTextOutput("summary")),
                     tabPanel("Structure",verbatimTextOutput("structure")),
                     tabPanel("Plot",plotOutput("plot"))
                     
         
        )
      )
    )
  )
)
