---
title       : Where am I ???
subtitle    : A simple shiny application
author      : Alessandro Vincenzi
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Instructions

1. The purpose of this application is to find the location where I am.
2. Three countries are loaded randomly from a csv file and proposed at every run.
3. The location where I am is among the three choices shown. You must guess it!
4. To help you out, two sliders can be used to move a red cursor on a Earth map.
5. Try to move it!
6. <b>Distance</b> measures the kilometers between the red cursor and the center of the country that you should guess.
7. The more you can reduce the kilometers, the closer you get to the right answer!
8. Once you find me, select the right choice and check it out.
9. You have only one chance ...
10. Reload the page to start a new session with a new location.

--- .class #id 

## Generating the cursor on the map

* The Earth maps showing the red cursor is generated with renderImage and shown every time a slider is moved

* An exeample of the usage of renderImage can be found here:

   http://www.inside-r.org/packages/cran/shiny/docs/renderImage

* A jpeg file is loaded from the www directoryr and the red circle is drawn setting the RGB values of its pixels.

* Every new jpeg image is created as a temporary file and then deleted

--- .class #id 

## Generating Random Locations

* Countries and their coordintes are read from a csv file stored in the directory www.

* The radio buttons are generated every time the page is loaded ad reported to the user interface using renderUi

* A minimum distance of 10000 Km is guaranteed

* The distance between two points at coordinates (80,30) and (0,-20) is computed as follow:


```r
library(fields)
```

```r
d<- rdist.earth(matrix ( c(80.0,  30.0), ncol=2), matrix ( c( 0.0, -20.0), ncol=2), miles = FALSE, R  =  6371)
round (d[1][1])
```

```
## [1] 10197
```

--- .class #id 

## References

* This presentation has been written using Slidify

   http://ramnathv.github.io/slidify/

* Coordinates are takent from The world Factbook, from the CIA web site:

   https://www.cia.gov/library/publications/the-world-factbook/fields/2011.html

* Check wikipedia for everithing else!

   http://www.wikipedia.org/

...



