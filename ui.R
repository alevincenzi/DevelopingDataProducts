library("shiny")

shinyUI(fluidPage(

        titlePanel("Where am I ???"),

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
                        
                        p("Find my current location moving the red cursor with the two sliders!. The distance reported
                          on the right measures how far the red cursor is from my location. Search in which coutry I am
                          and subimt your answer."),
                        p("Reload the page for a new search"),
                        
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
