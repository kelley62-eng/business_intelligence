# ISA 401 Midwest Airbnb Chat: ask questions, get SQL, a table, or a chart back
library(querychat)
library(shiny)
library(bslib)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

ui = page_navbar(
  title = "Midwest Airbnb Explorer",
  theme = bs_theme(preset = "minty"),
  nav_panel("Chat",
            layout_sidebar(
              sidebar = qc$sidebar(),
              card(card_header("SQL behind this view"), verbatimTextOutput("sql")),
              card(card_header("Listings"), DT::DTOutput("table"))
            )
  ),
  nav_panel("About",
            card(
              card_header("About this app"),
              p("Ask questions in plain English about Airbnb listings. The app writes SQL,",
                "runs it on the data, and shows the query behind every answer."),
              p(strong("Data source: "), "Inside Airbnb (insideairbnb.com), 14,887 listings from three snapshots:",
                "Chicago (2026-07-20), Columbus (2026-07-23), and the Twin Cities (2026-07-21)."),
              p(strong("Built by: "), "Kenneth Kelley, for ISA 401 Business Intelligence at Miami University.")
            )
  )
)

server = function(input, output, session) {
  vals = qc$server()
  output$sql = renderText({
    s = vals$sql()
    if (is.null(s) || s == "") "SELECT * FROM listings" else s
  })
  output$table = DT::renderDT(vals$df(), options = list(pageLength = 10, scrollX = TRUE))
}

shinyApp(ui, server)