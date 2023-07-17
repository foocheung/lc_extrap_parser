#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  metafile <- mod_dataInput_server("dataInput_ui_meta")
  callModule(mod_table_server, "tbl_box", metafile)
}
