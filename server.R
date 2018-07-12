library(shiny)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(party)
library(partykit)
library(tree)
library(randomForest)
library(e1071)
library(xtable)
library(caret)
library(pROC)
library(ROCR)
library(nnet)
library(rminer)
library(ggplot2)
library(xlsx)
library(RWeka)
library(kernlab)
library(Boruta)
library(descr)
setwd("E:/Desktop/shiny/shiny")
final=read.csv("selectedfeatures2.csv",header = TRUE)
shinyServer(function(input,output)
  {
 set.seed(1300)
  observe(
    {
      
      ind <- sample(2, nrow(selected_apis), replace=TRUE, prob=c(0.67, 0.33))
      #create 2 datasets from tables, without the last column (this is class label)
      selected_apis.train1<-selected_apis[ind==1,1:coln]
      selected_apis.test1<-selected_apis[ind==2,1:coln]
      
      selected_apis.train2<-selected_apis[ind==1,1:coln1]
      selected_apis.test2<-selected_apis[ind==2,1:coln1]
      selected_apis.train2<-selected_apis.train2[,-coln]
      selected_apis.test2<-selected_apis.test2[,-coln]
      
      #set class labels for training and test sets
      selected_apis.testlabels<-selected_apis[ind==2,coln]
      selected_apis.trainlabels<-selected_apis[ind==1,coln]
      
      
      selected_apis.testlabels.twoway<-selected_apis[ind==2,coln1]
      selected_apis.trainlabels.twoway<-selected_apis[ind==1,coln1]
      observeEvent(input$j48,{
        fit <-J48(as.factor(Class)~., data=selected_apis.train1)
        predictions <- predict(fit, selected_apis.test1)
        c<-CrossTable(selected_apis.testlabels, predictions)
          
            output$plot<-renderPlot(
              {plot(c)
      })
            output$summary<-renderPrint(
              {
                summary(final)
              }
            )
            output$structure<-renderPrint(
              {
                structure(fit)
              }
            )
          
          
        })
        
      
      
      observeEvent(input$svm,{
        fit <- ksvm(as.factor(Class)~., data=selected_apis.train1)
        predictions <- predict(fit, selected_apis.test1)
        
       c2<- CrossTable(selected_apis.testlabels, predictions)
        
        output$plot<-renderPlot(
          {plot(c2)
          })
        output$summary<-renderPrint(
          {
            summary(final)
          }
        )
        output$structure<-renderPrint(
          {
            structure(fit)
          }
        )
      
      })
      
      observeEvent(input$dtree,{
        fit <- randomForest(as.factor(Class)~., data=selected_apis.train1)
        predictions <- predict(fit, selected_apis.test1)
        c3<-CrossTable(selected_apis.testlabels, predictions)
        
        output$plot<-renderPlot(
          {plot(c3)
          })
        output$summary<-renderPrint(
          {
            summary(final)
          }
        )
        output$structure<-renderPrint(
          {
            structure(fit)
          }
        )
        
      })
}
)
  }
)
