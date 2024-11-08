% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetLakeCoordinatesTable.R
\name{GetLakeCoordinatesTable}
\alias{GetLakeCoordinatesTable}
\title{GetLakeCoordinatesTable}
\usage{
GetLakeCoordinatesTable(Lake)
}
\arguments{
\item{Lake}{Lake for which spatial coordinates should be returned.}
}
\value{
A data frame of coordinates for Lake.
}
\description{
The GetLakeCoordinatesTable function returns a data frame of spatial coordinates in geographic coordinate system (Lat/Lon) for a shallow lakes monitoring lake .
}
\examples{
# Get a data frame of spatial coordinates for Lake YUCH-004
LakeCoordinates = GetLakeCoordinatesTable('YUCH-004')
head(LakeCoordinates)
}
