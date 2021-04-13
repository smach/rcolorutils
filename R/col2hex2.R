#' Output hex code for built-in R color name
#' 
#' Built on the col2hex() function from the gplot package by Tal Galili with added error handling
#' 
#' @param cname character string name of a built-in r color
#'
#' @return character string with hex code
#' @export 
#'
#' @examples
#' col2hex("firebrick4")
col2hex2 <- function(cname) {
  tryCatch(
  colMat <- col2rgb(cname),
  error = function(e){
    message("There was an error, most likely because you supplied an invalid color name.")
  }
  )
  if(exists("colMat")){
    return(rgb(red = colMat[1, ]/255, green = colMat[2, ]/255, blue = colMat[3, 
    ]/255))
  } 
  
  
}
