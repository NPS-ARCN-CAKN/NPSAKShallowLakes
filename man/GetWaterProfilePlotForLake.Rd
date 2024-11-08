% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetWaterProfilePlotForLake.R
\name{GetWaterProfilePlotForLake}
\alias{GetWaterProfilePlotForLake}
\title{GetWaterProfilePlotForLake}
\usage{
GetWaterProfilePlotForLake(Lake, Parameter)
}
\arguments{
\item{Lake}{Name of the lake to profile.}

\item{Parameter}{Parameter to plot. Options 'Temperature','pH','DO','DO_PCT'. Anything else will cause a database error.}
}
\value{
A depth profile plot of Parameter by sampling date for Lake.
}
\description{
The GetWaterProfilePlotForLake function returns a depth profile plot of temperature by sampling date for Lake.
}
\examples{
# Example of use:
GetWaterProfilePlotForLake('BELA-033','DO_Pct')
GetWaterProfilePlotForLake('YUCH-004','Temperature')
}
