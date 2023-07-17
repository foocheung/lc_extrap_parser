#' dataInput UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#'
addResourcePath("d", "inst/app/www/")
mod_dataInput_ui <- function(id){
  ns <- NS(id)

  tagList(

    headerPanel(""),
    fileInput(
      inputId = ns("files"),
      label = "Choose Preseq Output txt Files",
      multiple = TRUE,
      accept = c("text/txt",
                 "text/tab-separated-values,text/plain",
                 ".txt")
    ),
    sliderInput(
      ns("n"),
      "Filter Number Unique Reads Expected:",
      min = 1000000,
      max = 50000000,
      value = 10000000,step = 1000000
    ),
    actionButton(ns("goButton"), "Go!")

  )

}

#' dataInput Server Functions
#'
#' @noRd
mod_dataInput_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns


    dat <- reactive({
      isolate({
        withProgress(message="Please wait...", detail="", value=0, max=100, {
          fff<<-input$files
      #    req(input$files)
          upload = list()



          if(length(input$files) == 0) {
            #  alert("No FCS file was found in the selected folder.")
          } else {
            ## setwd(bc$tempFilePath)

            inFile <- input$files
            ffffa<<-inFile
            files<-inFile$datapath

            ffff<<-files

            num<-input$n

            ten<-proc(input$n,inFile$datapath,inFile$name)



            }

        })

    })

      return(
        list(
          "dat" = ten,
          "n"=input$n,
          "datapath"=inFile$datapath,
          "inFilename"=inFile$name
        )
      )
      })

    ##FIX ONLY DO for 1 file errors


    proc<-function(num, files_list, file_names){
      #proc<-function(num){
      library(foreach)
      pca_all<-""
      df<-list()
      pca_all<-foreach (i=1:length(unlist(files_list)),.combine="rbind") %do% {
        #pca_all<-foreach (i=1:length(unlist(files_list)),.combine="rbind") %do% {

        #data<-read_tsv(files_list$batch1[i])
        data<-readr::read_tsv(files_list[i])
        files_list[i]
        dd<<-data
        max<-data %>%  dplyr::arrange(EXPECTED_DISTINCT) %>% dplyr::arrange(-EXPECTED_DISTINCT) %>% dplyr::top_n(1) %>% dplyr::pull(EXPECTED_DISTINCT)
        print(files_list[i])
        if (max < num){
          #res<-data %>% filter(EXPECTED_DISTINCT > 10000000) %>%top_n(-1)
          # c(files_list$batch1[i],NA)
          df[[i]]<-c(file_names[i],"","","","")
        }else{
          res<-data %>% dplyr::filter(EXPECTED_DISTINCT > num) %>% dplyr::top_n(-1)
          #  c(files_list$batch1[i],res)
          df[[i]]<-c(file_names[i],res)
        }

      }

    }



    return(list(
            df =dat,
           "goButton" = reactive({ input$goButton })
)
           )




   # return(list(c("datafile" = datafile, "userFile" = userFile)))
  })

}

## To be copied in the UI
# mod_dataInput_ui("dataInput_1")

## To be copied in the server
# mod_dataInput_server("dataInput_1")
