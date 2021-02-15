library(shiny)
library(shinythemes)
library(shinyjs)
library(shinyWidgets)
library(lubridate)
library(magrittr)

icona_narobe <- fluidRow(
  column(12,align="center",
         icon("fas fa-exclamation-triangle", lib = "font-awesome")
  ))

icona_ok <- fluidRow(
  column(12,align="center",
         icon("fas fa-check-circle", lib = "font-awesome")
  ))

