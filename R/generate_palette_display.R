


generate_palette_display <- function(my_palette_name) {

create_background_color <- function(myhex) {
  return( glue::glue("<span style='background-color:{myhex}; color: white;'>{myhex}</span>"))
}

my_html <- purrr::map_chr(as.character(paletteer_d(my_palette_name)), create_background_color)
if(length(my_html) > 6) {
  my_html <- my_html[1:6]
}
my_string <- paste0(my_html, collapse = " ")
return(my_string)

# Palette = c("IslamicArt::alhambra", "RColorBrewer::Dark2")
# Display = purrr::map_chr(Palette, generate_palette_display)

# mydf <- tibble::tibble(Palette, Display)
# DT::datatable(mydf, escape = FALSE)

}



