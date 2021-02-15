help =  tabPanel("Help",icon = icon("question"),value="help",
                 column(12,align="center",
                        br(),
                        br(),
                        br(),
                        br(),
                        actionButton("help_me","Informations",icon = icon("question")),
                        br(),
                        br(),
                        h4("Logins data:"),
                        br(),
                        dataTableOutput("logins")
                 )
)