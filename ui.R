library(shiny)
library(shinythemes)


fluidPage(
  
  theme = shinytheme("united"),
  
  navbarPage("eQTL Visualizer",
    
    
    tabPanel("Main",
    
      sidebarPanel(
        #textInput(inputId = "GENE", label = "Input gene ID:", value = "ENSSSAG00000088399"),
        selectInput(inputId = "GENE", label = "Input gene ID:", choices = gene_list),
        #HTML("<h4>OR</h4>"),

        # textAreaInput(inputId = "SNV_pasted", label = "Paste SNV IDs:", placeholder = "1:20000\n2:40000\n22:50000", height = "400px"),
        # HTML("<h4>OR</h4>"),

        # fileInput("file_in", "Upload file", accept = ".txt"),
        # #checkboxInput("header", "Header", TRUE),

        # HTML("<h5>ONLY accept txt file with each line is one SNV in chr:position format.</h5>"),
        actionButton(inputId = "submitbutton", label = "Submit", class = "btn btn-primary")
      ),
                                    
      mainPanel(
        hr(),
        tags$label(h4('Server status')),
        verbatimTextOutput('contents'),
        
        hr(),
        tags$label(h4('All treatments')),
        plotOutput("plot_all"),

        hr(),
        tags$label(h4('Light treatment: 8-16')),
        plotOutput("plot_8_16"),

        hr(),
        tags$label(h4('Light treatment: 12-12')),
        plotOutput("plot_12_12"),

        #tags$label(h4('SNP array content statistics')),
        #tableOutput('tabledata'),

        hr(),
        tags$label(h4('Light treatment: LL')),
        plotOutput("plot_ll"),
        
        hr(),
        tags$footer("FOOTER OF THE PAGE.... WILL BE ADDED LATER", align = "center"),
        tags$footer("(c) 2022 Dat T Nguyen", align = "center")
      ) 
    ),
    
    # tabPanel("Imputation performance",
    
    #   sidebarPanel(
    #     textInput(inputId = "SNV_region", label = "Paste SNVs region:", placeholder = "1:20000-50000"),
    #     HTML("<h4>OR</h4>"),

    #     textAreaInput(inputId = "SNV_pasted", label = "Paste SNVs ID:", placeholder = "1:20000\n2:40000\n22:50000", height = "400px"),
    #     HTML("<h4>OR</h4>"),

    #     fileInput("file_in", "Upload file", accept = ".txt"),
    #     #checkboxInput("header", "Header", TRUE),

    #     HTML("<h5>ONLY accept txt file with each line is one SNV in chr:position format.</h5>"),
    #     actionButton(inputId = "submitbutton", label = "Submit", class = "btn btn-primary")
    #   ),
                                    
    #   mainPanel(
    #     tags$label(h3('Server status')),
    #     verbatimTextOutput('contents'),
    #     tableOutput('tabledata')
    #   ) 
    # ),

    tabPanel("About", 
      titlePanel("About"), 
      div(includeMarkdown("about.md"), 
      align="justify")
    )
  )
)