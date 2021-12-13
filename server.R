#server.r
library(shiny)
library(ggplot2)
library(leaflet)
shinyServer(function(input, output){
  output$contents<-renderTable({
    infile<-input$file1
    if (is.null(infile))
      return(NULL)
    sum = read.csv(infile$datapath, header = input$header , sep = input$sep,quote = input$quote)
    sum
  })
  
  data<-reactive({
    infile<-input$file1
    if (is.null(infile))
      return(NULL)
    sum = read.csv(infile$datapath, header = input$header , sep = input$sep,quote = input$quote)
  })
  
  output$density = renderPlot({
    lm_reg = lm(formula = MEDV~.,data())
    X<-as.numeric(data()[,as.numeric(input$var)])
    d = ggplot(data(),aes(X,MEDV))+geom_point()+xlab(colnames(data())[as.numeric(input$var)]) + ylab("MEDV")
    print(d)
    if(input$gg){
      d + geom_smooth(method = lm, se = input$ver, size = 1)
    }
  })
  
  
  
  output$summary = renderPrint({
    summary(data())
    lm_reg = lm(formula = MEDV~.,data())
    summary(lm_reg)
  })
  
  output$table = renderTable({
    head(data())
  })
  
  output$plot <- renderPlot({
    
    ggplot(data(), aes(TAX, MEDV)) + geom_point()
  }, res = 96)
  
  output$data <- renderTable({
    brushedPoints(data(), input$plot_brush)
  })
  
  output$boxplot<- renderPlot({
    
    X<-as.numeric(data()[,as.numeric(input$var)])
    Y<-as.numeric(data()$MEDV)
    f<-ggplot(data=data(), mapping = aes(x=X, y=Y))+ geom_boxplot()+xlab(colnames(data())[as.numeric(input$var)]) + ylab("MEDV")
    print(f)
    #plot(x, y, log = "xy", xlab=colnames(data())[as.numeric(input$var)], ylab="MEDV")
  })
  
  output$histogram <- renderPlot({
    X<-as.numeric(data()[,as.numeric(input$var)])
    v <-  ggplot(data(), aes(x = X)) + 
      geom_histogram(color="black", fill="green")+xlab(colnames(data())[as.numeric(input$var)]) 
    
    print(v)
    
    
  })
 
  
  
})


  
  
  
  
  
  
    
  
