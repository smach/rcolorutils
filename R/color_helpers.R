# functions from the base R grDEvices::colors
# demo(colors)


##' Find close R colors() to a given color (original by Marius Hofert)
##' using Euclidean norm in (HSV / RGB / ...) color space
##' @param rgb Can be character string of built-in R color name like "tomato" or color rgb as vector ex c(255,99,71)
##' @author Marius Hofert, originally
##' @export
nearRcolor <- function(rgb, cSpace = c("hsv", "rgb255", "Luv", "Lab"),
                       dist = switch(cSpace, "hsv" = 0.10, "rgb255" = 30,
                                     "Luv" = 15, "Lab" = 12))
{
  if(is.character(rgb)) rgb <- col2rgb(rgb)
  stopifnot(length(rgb <- as.vector(rgb)) == 3)
  Rcol <- col2rgb(.cc <- colors())
  uniqC <- !duplicated(t(Rcol)) # gray9 == grey9 (etc)
  Rcol <- Rcol[, uniqC] ; .cc <- .cc[uniqC]
  cSpace <- match.arg(cSpace)
  convRGB2 <- function(Rgb, to)
    t(convertColor(t(Rgb), from="sRGB", to=to, scale.in=255))
  ## the transformation,  rgb{0..255} --> cSpace :
  TransF <- switch(cSpace,
                   "rgb255" = identity,
                   "hsv" = rgb2hsv,
                   "Luv" = function(RGB) convRGB2(RGB, "Luv"),
                   "Lab" = function(RGB) convRGB2(RGB, "Lab"))
  d <- sqrt(colSums((TransF(Rcol) - as.vector(TransF(rgb)))^2))
  iS <- sort.list(d[near <- d <= dist])# sorted: closest first
  setNames(.cc[near][iS], format(zapsmall(d[near][iS]), digits=3))
}



##' @title Compare Colors In A Plot
##' @param col the color name
##' @param nrow number of rows
##' @param ncol number of columns
##' @param txt.col text color
##' @return the grid layout, invisibly
##' @author Marius Hofert, originally
##' @export
plotCol <- function(col, nrow=1, ncol=ceiling(length(col) / nrow),
                    txt.col="black") {
  stopifnot(nrow >= 1, ncol >= 1)
  if(length(col) > nrow*ncol)
    warning("some colors will not be shown")
  require(grid)
  grid.newpage()
  gl <- grid.layout(nrow, ncol)
  pushViewport(viewport(layout=gl))
  ic <- 1
  for(i in 1:nrow) {
    for(j in 1:ncol) {
      pushViewport(viewport(layout.pos.row=i, layout.pos.col=j))
      grid.rect(gp= gpar(fill=col[ic]))
      grid.text(col[ic], gp=gpar(col=txt.col))
      upViewport()
      ic <- ic+1
    }
  }
  upViewport()
  invisible(gl)
}
