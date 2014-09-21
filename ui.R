library("shiny")

shinyUI(fluidPage(

        titlePanel("Where am I???"),

        sidebarLayout(
                
                position = "right",
                   
                sidebarPanel(
                        
                        uiOutput("radio"),

                        br(), br(),
                        
                        textOutput ("distance"),
                        
                        br(), br(),
                        
                        actionButton ("check",  "Check"),
                                
                        br(), br(),
                        
                        textOutput("result")
                ),
                
                mainPanel(
                        
                        imageOutput("finalEarthImage", width = "100%", height ="100%"),
 
                        br(), br(),
                        
                        sliderInput("longitude", "Longitude (E-W)",
                                    
                                    min = -180, max = 180, value = 0,
                                    
                                    step = 1, width = "100%", ticks = "TRUE"),
                
                        br(),

                        sliderInput("latitude", "Latitude (N-S)", 
                                    
                                    min = -90, max = 90, value = 0,
                                    
                                    step = 1, width = "100%", ticks = "TRUE")
                )
        )
))
