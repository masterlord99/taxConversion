source("lib.R")

# UI ----------------------------------------------------------------------


ui <- shinyUI({
  
  fluidPage(
    title = "SacredConversion",
    id = "mltwiz",
    shinyjs::useShinyjs(),
    setBackgroundImage("ahru.jpg",shinydashboard = F),
    # tags$head(tags$script(js_)),
    theme = shinytheme("paper"),
    column(6,align="center",
           br(),
           br(),
           br(),
           br(),
           br(),
           br(),
           h5(dateInput("date","Select date:",min = as.Date("2007-01-01"),max = Sys.Date(),value = as.Date("2020-01-01"),daysofweekdisabled = c(0,6))),
           br(),
           h5(selectInput("curr","Currency:",choices = c("USD"))),
           br(),
           h4(textOutput("ratio"))
           
    ),
    column(1),
    column(5,align="center",
           br(),
           br(),
           br(),
           br(),
           br(),
           br(),
           h5(numericInput("inp","Value in foreign currency:",value = 1000)),
           h5(numericInput("shares","Shares:",value = 1,min = 1,step = 1)),
           br(),
           br(),
           h4(textOutput("value"))
    )
  )
  
})

# server ------------------------------------------------------------------


server <- function(input, output,session){ 
  
  showModal({
    modalDialog(
      title=h2(
        icona_narobe
      ),
      fluidRow(column(12,align="center",
                      br(),
                      h5("Downloading latest currency ratios from Bank of Slovenia!"),
                      br(),
                      h5("Please wait (30 seconds)!"),
                      br(),
                      h5("App will activate automatically!"),
                      br(),
                      br())),
      easyClose = F,
      size = "m",
      footer=NULL
    )
  })
  
  # source("downloadData.R")
  
  updateDateInput(session,"date",max = max(df$TIME),min=min(df$TIME),value = as.Date("2021-01-04")) 
  
  updateSelectInput(session,"curr",choices = colnames(df)[-1],selected = "USD") 
  
  removeModal()
  
  
  ratio = reactiveValues(ratio=NA)
  
  output$ratio <- renderText({
    ratio$ratio = df[df$TIME==input$date,input$curr]
    paste0("Historic ratio: ",ratio$ratio)
    
  })
  
  output$value <- renderText({
    sh = input$shares
    if(is.na(sh)){sh=1}
    paste0("Historic value (EUR/per share) = ",round(input$inp/as.numeric(ratio$ratio)/sh,4))
    
  })
  
  
}



shinyApp(ui,server)
