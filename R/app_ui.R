#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function() {
  shinyUI( pageWithSidebar(
    HTML("<CENTER><H2>preseq lc_extrap parser"),
    # "",
    #theme="paper",
    tabPanel(
      "Load Data",
      sidebarPanel(
        mod_dataInput_ui(
          "dataInput_ui_meta"
        )
      )
    ),
    mainPanel(

     # tabsetPanel(

        mod_table_ui("tbl_box"),
  #  )

    )
  )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "lcextrap"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
