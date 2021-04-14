#' Generate an interactive, searchable table of built-in R colors
#'
#' @param page_length integer for length of table page, defaults to 25
#'
#' @return DT object with HTML of table that displays correctly in RStudio
#' @export
#'
create_color_table <- function(page_length = 25) {
  rcolornames <- colors()
  rcolorhex <- col2hex2(rcolornames)
  rcolorrgb <- purrr::map_df(rcolornames, col2rgb2)
  rcolorhtml <- sapply(rcolornames, col2htmlspan_notext, character_length = 30)
  data_for_table <- data.frame(rcolornames, rcolorhtml, rcolorhex, rcolorrgb)

  DT::datatable(data_for_table, escape = FALSE, filter = 'top', rownames = FALSE, options = list(
    pageLength = page_length,
    lengthMenu = c(page_length, 50, 100, 1000),
    search = list(regex = TRUE, caseInsensitive = TRUE)
  ))
}


