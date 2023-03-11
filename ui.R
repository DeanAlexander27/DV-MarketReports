library(shiny)
library(shinydashboard)

ui <- dashboardPage( skin = "red",
                     
                     dashboardHeader(title = "PT.A Supply Chain Division"),
                     
                     dashboardSidebar(
                       sidebarMenu(
                         menuItem("Welcome Message !", tabName = "welcome", icon = icon("send",lib = "glyphicon")),
                         menuItem("Dashboard Year on Year", tabName = "dashboard", icon = icon("dashboard")),
                         menuItem("Dashboard Progress", tabName = "progress", icon = icon("dashboard"),
                                  badgeLabel = "New !", badgeColor = "green"),
                         menuItem("Data",icon = icon("users"),tabName = "data",
                                  badgeLabel = "New !", badgeColor = "green")
                       )
                     ),
                     
                     dashboardBody(
                       tags$style(HTML(".small-h2 {font-size: 16px;}",
                                       HTML(".small-h1 {font-size: 18px;}")
                                       )),
  
  tabItems(
    tabItem(tabName = "welcome",
            h1(strong("Supply Chain Dashboard"), align ="center"),
            p("This report dashboard provides a comprehensive overview of PT.A's performance during the second quarter of 2022, with a focus on its sales, distribution, and stock levels. The dashboard presents key metrics such as total sales, revenue, growth rate, market share, distribution network, and stock levels in an easy-to-understand visual format. Additionally, it includes relevant market information that can help in understanding PT.A's performance in the broader industry context. The report aims to provide a transparent and objective view of PT.A's progress towards its goals and objectives, while also highlighting areas for improvement and growth opportunities.", align ="justify", class="small-h2"),
            br(),
            h1(strong("Defination name of columns, here is the explanation :"),class="small-h1"),
            br(),
            p("Sales = Total count of unit have already sold in the of the month"),
            br(),
            p("Intransit 1 = Total count of unit still on progress delivery into PT.A's Warehouse"),
            br(),
            p("Manufacturing Distribution = Total count of distribution unit into PT.A's warehouse"),
            br(),
            p("Total Stock = Total stock of unit in the end of the month"),
            br(),
            p("Stock Retail = total stock on retail in the end of the month")
            
            ),
    
    tabItem(tabName = "dashboard",
            fluidRow(column(width = 9,
              box(plotlyOutput(outputId = "progress2022"),width = 12),
              
              box(plotlyOutput(outputId = "progress2022.1"),width = 12) ),
                     
              column(width = 3,
                            infoBox(title = strong("Total Sales 2022"), width = NULL,value = 35041, icon = icon("credit-card"), fill = TRUE,color='red'),
                     infoBox(title = strong("Distribution 2022"), width = NULL,value = 29982, icon = icon("truck"),fill = TRUE,color='orange'),
                     infoBox(title = strong("Total Stock 2022"), width = NULL,value = 2685, icon = icon("boxes-stacked"),fill = TRUE),
                     tabBox(
                       title = strong("Market Information", align = "center"),
                       # The id lets us use input$tabset1 on the server to find the current tab
                       id = "tabset1",height = 425, width = NULL,
                       tabPanel(strong("Positive Info"), div(style = "text-align:justify",
                        p("As we can see from the graphic , sales progress in July 2022 still concistent in past 2 months,
                          but if we compare with 2019 in condition without covid, not in recovery sales at all"),
                        br(),
                        p("Comparing with 2020 progress sales from January to June, 2022 have a great progress sales and distribution from manufacturing"),
                        br(),
                        p("2021 still looking great than progress 2022, and still on progress about the cause effect by team sales area")
                        )),
                       tabPanel(strong("Negative Info"), div(style = "text-align:justify",
                                                             p("Manufacturing's side getting lower in past 2 months, the cause is being sought knowing")))
                     )
              )
            )
    )
    
          ,
            
            tabItem(tabName = "progress",
                    h2(strong("Progress Sales, Intransit 1, Total Stock, Stock Retail"),class="small-h2"),
                    br(),
                    fluidRow(
                    column(width = 4,
                    selectInput(inputId = "input1",
                                label ="Choose Year",
                                choices = levels(dataset1$year))),
                    
                    column(width = 4,
                           selectInput(inputId = "input3",
                                       label ="Choose Category",
                                       choices = levels(dataset1$Category)))),
                    fluidRow(
                      column(width = 4,
                             box(plotlyOutput(outputId = "progress2022.2"),width = NULL),
                             box(plotlyOutput(outputId = "progress2022.3"),width = NULL)),
            
                      column(width = 4,
                             box(plotlyOutput(outputId = "progress2022.4"),width = NULL),
                             box(plotlyOutput(outputId = "progress2022.5"),width = NULL)),
                      
                      column(width = 4,
                             box(plotlyOutput(outputId = "progress2022.6"),width = NULL)))
                    
                    
                    ),
    
            tabItem(tabName = "data",
                    h2("Data PT.A 2019 - 2022"),
                    dataTableOutput("table_data"))
            
            
    )
                     )
)







