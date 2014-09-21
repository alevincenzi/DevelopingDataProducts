library("shiny")
library("fields")
library("jpeg")

earthImage <- readJPEG ("www/earth.jpg")

# https://www.cia.gov/library/publications/the-world-factbook/fields/2011.html

data <- read.csv ("www/countries.csv", header = FALSE)

data$latitude <- as.numeric(data$V2) * ifelse (data$V4 == "N", 1, -1) ;

data$longitude <- as.numeric(data$V5) * ifelse (data$V7 == "E", 1, -1) ;

data$country <- as.character (data$V1)

minDistance   <- 5000
goalLatitude  <- 0
goalLongitude <- 0
goal          <- 0

shinyServer(function(input, output, session) {
                
        distFromGoal <- function(latitude, longitude)
        {
                d<- rdist.earth ( matrix ( c(    latitude,     longitude), ncol=2),
                                  matrix ( c(goalLatitude, goalLongitude), ncol=2),
                                  miles = FALSE, 
                                  R    =  6371)

                round (d)
        }
        
        testDist <- function(first_row, second_row)
        {
                d<- rdist.earth ( matrix ( c(data [first_row, ]$latitude, data [first_row, ]$longitude), ncol=2),
                                  matrix ( c(data [second_row,]$latitude, data [second_row,]$longitude), ncol=2),
                                  miles = FALSE, 
                                  R    =  6371)
                
                if (round (d) > minDistance)
                        
                        TRUE
                
                else
                        FALSE
        }
        
        loadNewList <- function()
        {
                first  <- sample(1:nrow(data), 1)
                second <- 1
                third  <- 1
                
                repeat
                {
                        second <- sample(1:nrow(data), 1)
                        
                        if (testDist(first, second) == TRUE)
                        {
                                break
                        }
                } 

                repeat
                {
                        third <- sample(1:nrow(data), 1)
                        
                        if (testDist(first, third) && testDist(second, third))
                        {
                                break
                        }
                } 

                goal <<- sample (1:3, 1)
                
                if (goal == 1)
                {
                        goalLatitude  <<- data[first,]$latitude
                        goalLongitude <<- data[first,]$longitude
                }
                
                else if (goal == 2)
                {
                        goalLatitude  <<- data[second,]$latitude
                        goalLongitude <<- data[second,]$longitude
                }
                else
                {
                        goalLatitude  <<- data[third,]$latitude
                        goalLongitude <<- data[third,]$longitude
                }

                tmp <- list ("a" = 1, "b" = 2, "c" = 3)
                
                names (tmp) <- c(data[first,]$country, data[second,]$country, data[third,]$country)
                
                tmp
        }
                        
        output$radio <- renderUI(radioButtons(
                
                "radio",
                
                label = h3("Guess my location!"),
                
                choices = loadNewList(),
                
                selected = 1
                
        ))
        
        output$distance <- renderText(paste ("Current distance: ", distFromGoal(input$latitude, input$longitude), " Km"))
        
        output$finalEarthImage <- renderImage({

                width  <- session$clientData$output_finalEarthImage_width
                height <- session$clientData$output_finalEarthImage_height
        
                outfile <- tempfile(fileext = ".png")
        
                # Generate the image and write it to file

                X <- 2048 # width, on x axis
                Y <- 1024 # heigth, on y axis
                
                cx <- round( (X  * (  input$longitude + 180)) / 360) # coordinate on x axis [-180 : 180]
                cy <- round( (Y  * (- input$latitude  +  90)) / 180) # cordinate  on y axis [ -90 :  90]
                
                Red   <- X * Y * 0
                Green <- X * Y * 1
                Blue  <- X * Y * 2
                
                for (angle in 0 : 628)
                {
                        for (radius in 14:10)
                        {        
                                x = round(cx  + radius * cos(angle / 100))
                                y = round(cy  + radius * sin(angle / 100))
                                
                                pixel <- x * Y + y
                                
                                if (x > 0 && x < X && y > 0 && y < Y)
                                {
                                        earthImage [Red   + pixel ] <- 1.0
                                        earthImage [Green + pixel ] <- 0.0
                                        earthImage [Blue  + pixel ] <- 0.0
                                }
                        }
                }
                
                writeJPEG(earthImage, target = outfile)
        
                # Return a list containing information about the image
                list(
                        src = outfile,
                        contentType = "image/jpg",
                        width = width,
                        height = height,
                        alt = ""
                )
        
        }, deleteFile = TRUE)


        output$result <- renderText({

                if (input$check == 0)
                        
                        return ("")
                
                if (input$check > 1)
                        
                        return ("Reload the application and try again!")
                
                isolate({
                        
                        if (input$radio == goal)
                        
                                return ("You found me!")

                        else
                                
                                return ("Not there!")
                        
                })
        })
        
        #output$referenceA <- renderText(goal)
        #output$referenceB <- renderText(goalLatitude)
        #output$referenceC <- renderText(goalLongitude)
        
})
