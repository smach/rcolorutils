#' Generate an interactive, searchable table of built-in R colors
#'
#' @return DT object with HTML of table that displays correctly in RStudio
#' @export
#'
create_color_table <- function() {
  rcolornames <- colors()
  rcolorhex <- col2hex2(rcolornames)
  rcolorhtml <- sapply(rcolornames, col2htmlspan_notext, character_length = 30)
  data_for_table <- data.frame(rcolornames, rcolorhex, rcolorhtml)
  
  DT::datatable(data_for_table, escape = FALSE, filter = 'top', rownames = FALSE, options = list(
    pageLength = 25,
    lengthMenu = c(25, 50, 100, 1000),
    search = list(regex = TRUE, caseInsensitive = TRUE)
  ))
}


