#' Generate HTML to display background color for a built-in R color
#'
#' @param colorname character string of a built-in R color name
#' @param text character string for text you want to appear over the background color, if any
#' @param textcolor character string for the color of the text you want to appear over the background color, if any
#'
#' @return character string with HTML
#' @export
#'
#' @examples
#' col2htmlspan_notext("firebrick4")
col2htmlspan_notext <- function(colorname, character_length = 30) {
  colorhex <- col2hex2(colorname)
  mytext <- rep("&nbsp;", character_length)
  mytext <- paste0(mytext, collapse = "")
  return( glue::glue("<span style='background-color:{colorhex}; color: {colorhex};'>{mytext}</span>"))
}
