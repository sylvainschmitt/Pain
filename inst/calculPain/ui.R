ui <- shinyUI(fluidPage(

    titlePanel("Pain"),
    sidebarLayout(
        sidebarPanel(
            helpText("Shiny app based on an example given in the rhandsontable package.",
                     "Right-click on the table to delete/insert rows.",
                     "Double-click on a cell to edit"),

            br(),

            wellPanel(
                h3("Save table"),
                div(class='row',
                    div(class="col-sm-6",
                        actionButton("save", "Save")),
                    div(class="col-sm-6",
                        radioButtons("fileType", "File type", c("ASCII", "RDS")))
                )
            )

        ),

        mainPanel(

            br(), br(),

            fluidRow(
                h3("Débouchés"),
                column(4,
                       uiOutput("ui_newcolname"),
                       actionButton("addcolumn", "Ajouter")
                ),
                column(4,
                       uiOutput("ui_rmcolname"),
                       actionButton("rmcolumn", "Supprimer")
                ),
                column(4,
                       actionButton("quit", "Quitter", icon = icon("sign-out-alt"))
                )
            ),

            rHandsontableOutput("hot"),
            br()

        )
    )
))
