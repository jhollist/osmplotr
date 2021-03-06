% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/highways2polygon.R
\name{highways2polygon}
\alias{highways2polygon}
\title{highways2polygon}
\usage{
highways2polygon(highways = NULL, bbox = NULL, plot = FALSE)
}
\arguments{
\item{highways}{A vector of highway names passed directly to the Overpass
API. Wildcards and whitespaces are '.'; for other options see online help for
the overpass API.}

\item{bbox}{the bounding box for the map.  A 2-by-2 matrix of 4 elements with
columns of min and max values, and rows of x and y values.}

\item{plot}{If TRUE, then all OSM data for each highway is plotted and the
final cycle overlaid.}
}
\value{
A single data.frame containing the lat-lon coordinates of the cyclic
line connecting all given streets.
}
\description{
Takes a list of highways names which must enclose an internal area, and returns
a SpatialLines object containing a sequence of OSM nodes which cyclically
connect all highways. Will fail if the streets do not form a cycle.
}

