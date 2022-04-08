library(shiny)
library(shinythemes)
library(data.table)
library(ggplot2)


# functions and loading databases
load_db <- function(db){
  load(db)
  return(database)
}

db_all = load_db("data_test/all_treatments.Rdata")
db_8_16 = load_db("data_test/light_treatment_8_16.Rdata")
db_12_12 = load_db("data_test/light_treatment_12_12.Rdata")
db_ll = load_db("data_test/light_treatment_LL.Rdata")

gene_list = intersect(names(db_all), names(db_8_16))
gene_list = intersect(gene_list, names(db_12_12))
gene_list = intersect(gene_list, names(db_ll))

gene_list = as.list(gene_list)

plot_fun_all<- function(gene){
   ggplot(db_all[[gene]]$df, aes(x = Minor_allele_count, y = Quantile_normialized_exp, color = Minor_allele_count)) + geom_boxplot() + xlab(db_all[[gene]]$text) + ylab("Quantile normialized expression") + ggtitle(db_all[[gene]]$sum_stat) + scale_y_continuous(limits = c(-3.5, 5.5)) + theme_bw()
}

plot_fun_8_16 <- function(gene){
   ggplot(db_8_16[[gene]]$df, aes(x = Minor_allele_count, y = Quantile_normialized_exp, color = Minor_allele_count)) + geom_boxplot() + xlab(db_8_16[[gene]]$text) + ylab("Quantile normialized expression") + ggtitle(db_8_16[[gene]]$sum_stat) + scale_y_continuous(limits = c(-3.5, 5.5)) + theme_bw()
}

plot_fun_12_12 <- function(gene){
   ggplot(db_12_12[[gene]]$df, aes(x = Minor_allele_count, y = Quantile_normialized_exp, color = Minor_allele_count)) + geom_boxplot() + xlab(db_12_12[[gene]]$text) + ylab("Quantile normialized expression") + ggtitle(db_12_12[[gene]]$sum_stat) + scale_y_continuous(limits = c(-3.5, 5.5)) + theme_bw()
}

plot_fun_ll <- function(gene){
   ggplot(db_ll[[gene]]$df, aes(x = Minor_allele_count, y = Quantile_normialized_exp, color = Minor_allele_count)) + geom_boxplot() + xlab(db_ll[[gene]]$text) + ylab("Quantile normialized expression") + ggtitle(db_ll[[gene]]$sum_stat) + scale_y_continuous(limits = c(-3.5, 5.5)) + theme_bw()
}

gene_defaut = "ENSSSAG00000070825"


shinyServer <- function(input, output, session) {
  
  # Status/Output Text Box
  output$contents <- renderText({
    if (input$submitbutton>0){ 
      out_gene = paste0("Viewing your selected gene: ", input$GENE, ".")
      isolate(out_gene) 
    } else {
      out_defaut = paste0("Viewing the defaut gene: ", gene_defaut, ".")
      isolate(out_defaut)
    }
  })
  

  # Input Data
  datasetInput <- reactive({  
    
    gene = input$GENE

    p_all = plot_fun_all(gene)

    p_8_16 = plot_fun_8_16(gene)

    p_12_12 = plot_fun_all(gene)

    p_ll = plot_fun_ll(gene)
    
    res = list(p_all = p_all, p_8_16 = p_8_16, p_12_12 = p_12_12, p_ll = p_ll)
    print(res)

  })

  datasetInput_defaut <- reactive({  
    
    gene = gene_defaut

    p_all = plot_fun_all(gene)

    p_8_16 = plot_fun_8_16(gene)

    p_12_12 = plot_fun_all(gene)

    p_ll = plot_fun_ll(gene)
    
    res = list(p_all = p_all, p_8_16 = p_8_16, p_12_12 = p_12_12, p_ll = p_ll)
    print(res)

  })


  # outputs
  # output$tabledata <- renderTable({
  #   if (input$submitbutton>0) { 
  #     isolate(datasetInput()$df) 
  #   } 
  # })

  output$plot_all <- renderPlot({
    if (input$submitbutton>0) { 
      isolate( datasetInput()$p_all ) 
    }else{
      isolate( datasetInput_defaut()$p_all )
    } 
  })

  output$plot_8_16 <- renderPlot({
    if (input$submitbutton>0) { 
      isolate( datasetInput()$p_8_16 ) 
    }else{
      isolate( datasetInput_defaut()$p_8_16 )
    }
  })

  output$plot_12_12 <- renderPlot({
    if (input$submitbutton>0) { 
      isolate( datasetInput()$p_12_12 ) 
    }else{
      isolate( datasetInput_defaut()$p_12_12 ) 
    } 
  })

  output$plot_ll <- renderPlot({
    if (input$submitbutton>0) { 
      isolate( datasetInput()$p_ll ) 
    }else{
      isolate( datasetInput_defaut()$p_ll ) 
    } 
  })
  
}
