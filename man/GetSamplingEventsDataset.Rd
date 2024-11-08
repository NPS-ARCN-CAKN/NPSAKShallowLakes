% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetSamplingEventsDataset.R
\name{GetSamplingEventsDataset}
\alias{GetSamplingEventsDataset}
\title{GetSamplingEventsDataset}
\usage{
GetSamplingEventsDataset()
}
\value{
A data frame of Lakes data.
}
\description{
Queries the [tblEvents] database table and returns the records as a data frame. This table contains information about each lake's sampling visit.
}
\examples{
# Example of use:
data = GetSamplingEventsDataset()
head(data)
}
