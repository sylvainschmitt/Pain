library(rhandsontable)
library(shiny)

ui <- shinyUI(fluidPage(

    titlePanel("Pain"),
    sidebarLayout(
        sidebarPanel(
            helpText("Double-click on a cell to edit"),

            br(),

            wellPanel(
                h3("Save table"),
                div(class='row',
                    div(class="col-sm-6",
                        actionButton("save", "Save")),
                )
            )

        ),

        mainPanel(

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
            br(),

            rHandsontableOutput("hot"),
            br(),

            fluidRow(
                column(6,
                       h3("Table"),
                       actionButton("makeTable", "Générer la table"),
                       uiOutput("ui_table")
                ),
                column(6,
                       h3("Graphique"),
                       # actionButton("makeGraphique", "Générer le graphique"),
                       plotOutput("ui_graphique")
                ),
            ),
            br(),



        )
    )
))
