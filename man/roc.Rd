\name{roc}

\alias{roc}
\alias{getRoc}
\alias{roc,vector,vector-method}
\alias{roc,sdmModels-method}
\alias{roc,sdmModels,ANY-method}
\alias{getRoc,vector,vector-method}
\alias{getRoc,sdmModels,ANY-method}

\title{plot ROC curves}

\description{
Plot the Receiver Operating Characteristics (ROC) curve with AUC statistic in the legend.
}

\usage{
roc(x, p = NULL, species = NULL, method = NULL, replication = NULL, run = NULL,
     wtest = NULL, smooth = FALSE, legend = TRUE,...)
     
getRoc(x, p,...)
}

\arguments{
  \item{x}{either \code{sdmModels}, or \code{sdmEvaluate} object; or a numeric vector including observed binary values of species occurrence}
  \item{p}{if x is sdmModels, p is an optional vector with model ID number(s) that should be plotted (NULL (default means all models)); if x is a numeric vector, p is a vector with the same length including the predicted values}
  \item{species}{the name of species should be specified (required if x is \code{sdmModels} containing models for several species)}
  \item{method}{a character vector with the name of modelling methods that one needs to get the roc plot for (if NULL  [default], all methods in the object are considered); only if x is \code{sdmModels}}
  \item{replication}{a character vector with the name of replication methods (i.e., 'sub','cv','boot') that one needs to get the roc plot for}
  \item{run}{if x is \code{sdmModels}, and the models are fitted through a replication procedure, run specifies which runs of the partitioning (replications) are required; if NULL, all are considered}
  \item{wtest}{evaluation for which test datasets are required, maximum 2 names from 'training', 'test.dep', 'test.indep' (i.e., evaluation for training data, dependent test dataset, and independent test dataset, respectively)}
  \item{smooth}{logical, specifies whether the ROC curves should be smoothed through a spline procedure}
  \item{legend}{logical, specified whether a legend including AUC statistic is required on the plot}
  \item{...}{additional arguments passed to plot function}
  }
\details{
roc generates the plots of roc curves, and getRoc generate the values of ROC
}

\value{
 an object of class \code{matrix}
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
file <- system.file("external/model.sdm", package = "sdm")

m <- read.sdm(filename = file) # a sdmModels Object (fitted using sdm function)

roc(x = m)

roc(x = m, p = 1) # for the first model

roc(x = m, p = 1:2)

roc(x = m, method = 'glm', smooth = TRUE) # only for models fitted using glm method & with smoothed curve


}
}

\keyword{spatial}
\keyword{accuracy}
\keyword{model}
