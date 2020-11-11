library(rhandsontable)
library(shiny)

DF = data.frame(Type = c(rep("Nature",4), rep("Graines",3), rep("PAC",1), rep("Sarasin",2)),
                Poids = as.character(c(0.5, 1, 1.5, 2, 0.5, 1, 1.5, 0.25, 0.5, 1)),
                "Le chêne" = as.integer(rep(0, 10)))

server <- shinyServer(function(input, output) {

    values <- reactiveValues(totaux = data.frame(),
                             fournees = data.frame(),
                             graphique = NULL)

    ## Handsontable
    observe({
        if (!is.null(input$hot)) {
            values[["previous"]] <- isolate(values[["DF"]])
            DF = hot_to_r(input$hot)
        } else {
            if (is.null(values[["DF"]]))
                DF <- DF
            else
                DF <- values[["DF"]]
        }
        values[["DF"]] <- DF
    })

    output$hot <- renderRHandsontable({
        DF <- values[["DF"]]
        if (!is.null(DF))
            rhandsontable(DF, useTypes = TRUE, stretchH = "all")
    })

    ## Save
    observeEvent(input$save, {
        fileType <- isolate(input$fileType)
        finalDF <- isolate(values[["DF"]])
        if(fileType == "ASCII"){
            dput(finalDF, file=file.path("./", sprintf("%s.txt", outfilename)))
        }
        else{
            saveRDS(finalDF, file=file.path("./", sprintf("%s.rds", outfilename)))
        }
    }
    )

    ## Débouchés
    output$ui_newcolname <- renderUI({
        textInput("newcolumnname", "Ajouter", sprintf("débouché %s", 1+ncol(values[["DF"]])-2))
    })
    observeEvent(input$addcolumn, {
        DF <- isolate(values[["DF"]])
        values[["previous"]] <- as.integer(rep(0, nrow(DF)))
        newcolumn <- eval(parse(text=sprintf('%s(nrow(DF))', "integer")))
        values[["DF"]] <- setNames(cbind(DF, newcolumn, stringsAsFactors=FALSE), c(names(DF), isolate(input$newcolumnname)))
    })
    output$ui_rmcolname <- renderUI({
        DF <- isolate(values[["DF"]])
        selectInput("rmcolumnname", "Supprimer", names(DF)[-c(1,2)])
    })
    observeEvent(input$rmcolumn, {
        DF <- isolate(values[["DF"]])
        values[["DF"]] <- DF[,-which(names(DF) == input$rmcolumnname)]
    })

    ## Table
    observeEvent(input$makeTable, {

        DF <- isolate(values[["DF"]])
        totaux <- calculTotaux(DF)
        fournees <- calculFournees(totaux)
        values[["totaux"]] <- totaux
        values[["fournees"]] <- fournees
    })
    output$ui_table <- renderTable({
        values$fournees
    })

    ## Graphique
    output$ui_graphique <- renderPlot({
        graphFournees(values[["fournees"]])
    })

    ## Quit
    observeEvent(input$quit, {
        stopApp()
    })

})
