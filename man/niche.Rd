\name{niche}

\alias{niche}
\alias{niche,RasterStackBrick,RasterLayer-method}
\alias{niche,RasterStackBrick,SpatialPoints-method}
\alias{niche,RasterStackBrick,sdmdata-method}
\alias{niche,sdmdata,ANY-method}
\alias{plot,.nicheRaster-method}
\alias{plot,.nicheSpatRaster-method}
\alias{niche,SpatRaster,SpatRaster-method}
\alias{niche,SpatRaster,SpatVector-method}
\alias{niche,SpatRaster,sdmdata-method}


\title{Generate and plot Ecological Niche}

\description{
This function maps the species data (either presence-absence or probability of occurrence/habitat suitability) into a two-dimensional environmental space (i.e., based on two environmental variables) to characterise ecological niche based on the specified environmental variables.
}

\usage{
niche(x, h, n, .size, plot, out,...)

}

\arguments{
  \item{x}{A \code{Raster*} object (or sdmdata) containing environmental variables}
  \item{h}{A \code{RasterLayer}, or \code{SpatialPoints}, or \code{sdmdata} object that represents species data either in the form of habitat suitability (e.g., probability of occurrence) or presence-absence (or even presence-only) data}
  \item{n}{A character vector specifying the names of environmental variables (two names) that should be used to map the ecological niche; if \code{h} is a \code{SpatialPoints} or \code{sdmdata} object, a third name may be added specifying the species name (e.g., the name of the column in \code{SpatialPointsDataFrame} containing species data)}
  \item{.size}{optional; a numeric value (default: 1e6), specifies the size of the maximum number of records that should be used to generate the ecological niche map; would be useful when the \code{Raster*} object introduced in \code{x} is big, then a random sample with the specified .size will be drawn based on which the niche is generated}
  \item{plot}{logical, specifies whether the generated niche should be plotted}
  \item{out}{logical (default: TRUE), specifies whether the niche should be returned by the function; it will be \code{TRUE} if \code{plot} is \code{FALSE}}
  \item{...}{additional arguments including the argument \code{gg} (see details) and other arguments passed to the plot function}
  }
\details{
As an additional argument, a user may specify \code{gg} which is logical, specifies whether the plot should be generated using the ggplot2 package (if the package is installed), otherwise, the terra package is used to generate the plot.
  
- \code{...}: additional arguments for the \code{plot} function (e.g., xlab, ylab, main, col, ...) can be used with the function


}


\value{
 an object of class \code{.nicheSpatRaster} that contains some information about the included pair of environmental variables, and a RasterLayer (100x100) that represents the two-dimensional ecological niche.
}


\references{
Naimi, B., Araujo, M.B. (2016) sdm: a reproducible and extensible R platform for species distribution modelling, Ecography, 39:368-375, DOI: 10.1111/ecog.01881
}

\author{Babak Naimi \email{naimi.b@gmail.com}

\url{https://www.r-gis.net/}

\url{https://www.biogeoinformatics.org/}
}


\examples{
\dontrun{

file <- system.file("external/species.shp", package = "sdm") # get the location of the species data

species <- vect(file) # read the shapefile

path <- system.file("external", package = "sdm") # path to the folder containing the data

lst <- list.files(path = path, pattern = 'asc$', full.names = TRUE) # list the full path and names of the raster files 


# rast is a function in the terra package, to read/create a multi-layers SpatRaster dataset
preds <- rast(lst) # making a SpatRaster object

names(preds) # 4 environmental variables are used!

d <- sdmData(formula = Occurrence ~., train = species, predictors = preds)

d

# fit models:
m <- sdm(formula = Occurrence ~., data = d, methods = c('rf', 'glm', 'brt'))

# ensemble using weighted averaging based on AUC statistic:    
p1 <- ensemble(x = m, newdata = preds, setting = list(method = 'weighted', stat = 'AUC'))
plot(p1, main = 'Habitat Suitability in Geographic Space')

# Mapping Ecological Niche using selected two variables
niche(x = preds, h = p1, c('precipitation', 'temperature'))

niche(x = preds, h = p1, c('vegetation', 'temperature'))

# in case if you do not have the habitat suitability map but species data:

niche(x = preds, h = species, c('vegetation', 'temperature', 'Occurrence'))


niche(x = preds, h = d, n = c('vegetation', 'temperature', 'Occurrence'), rnd = 2) 
# rnd is the argument that specifies the decimal degrees to which the values on axis should be rounded.



}
}

\keyword{spatial}
\keyword{species}
\keyword{data}
