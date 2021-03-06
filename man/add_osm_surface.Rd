% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/add-osm-surface.R
\name{add_osm_surface}
\alias{add_osm_surface}
\title{add_osm_suface}
\usage{
add_osm_surface(obj = obj, dat = NULL, method = "idw", bg = NULL,
  cols = terrain.colors(30), border = FALSE, verbose = FALSE, ...)
}
\arguments{
\item{obj}{an sp SPDF or SLDF (list of polygons or lines) returned by
extract_osm_objects ()}

\item{dat}{A matrix or data frame of 3 columns (x, y, z), where (x, y) are
(longitude, latitude), and z are the values to be interpolated}

\item{method}{Either 'idw' (Inverse Distance Weighting as spatstat::idw;
default), otherwise uses 'Gaussian' for kernel smoothing (as
spatstat::Smooth.ppp)}

\item{bg}{If specified, OSM objects outside the convex hull surrounding 'dat'
are plotted in this colour, otherwise they are included in the interpolation
(which will generally be inaccurate for peripheral values)}

\item{cols}{Vector of colours for shading z-values (for example,
'terrain.colors (30)')}

\item{border}{Plot border? (For SpatialPolygons only)}

\item{verbose}{If TRUE, provides notification of progress}

\item{...}{other parameters to be passed to polygons, lines (such as lwd,
lty), or points (such as pch, cex)}
}
\value{
Range of interpolated values (which may differ from range of 'dat$z'
as submitted, and can be used to scale 'add_colourbar()')
}
\description{
Adds a colour-coded surface of spatial objects (polygons, lines, or points
generated by extract_osm_objects ()) to a graphics object initialised with
plot_osm_basemap(). The surface is spatially interpolated between the values
given in 'dat', which has to be a matrix or data.frame of 3 colums (x, y, z),
where (x,y) are (longitude, latitude), and z are the values to be
interpolated. Interpolation uses spatstat::Smoothing.ppp, which applies a
Gaussian kernel smoother optimised to the given data, and is effectively
non-parametric.
}
\note{
Spatial smoothing is *interpolative* and so values beyond the bounding
polygon of 'dat' will generally be unreliable. Points beyond the bounding
polygon are only included in the interpolation if 'bg' is NA or NULL.
}
\examples{
plot_osm_basemap (bbox=get_bbox (c (-0.15, 51.5, -0.1, 51.52)), col="gray20")
add_osm_objects (london$dat_BNR, col="gray40") # non-residential buildings
bbox <- get_bbox (c (-0.15, 51.5, -0.1, 51.52))
x <- seq (bbox [1,1], bbox [1,2], length.out=dim (volcano)[1])
y <- seq (bbox [2,1], bbox [2,2], length.out=dim (volcano)[2])
xy <- cbind (rep (x, dim (volcano) [2]), rep (y, each=dim (volcano) [1]))
z <- as.numeric (volcano)
plot_osm_basemap (bbox=bbox, bg="gray20")
# uncomment to run: can be time-consuming
# zl <- add_osm_surface (london$dat_BNR, dat=cbind (xy, z), method="idw")
cols <- adjust_colours (terrain.colors (30), -0.2) # Darken by ~20\%
# zl <- add_osm_surface (london$dat_H, dat=cbind (xy, z), cols=cols)
# zl <- add_osm_surface (london$dat_HP, dat=cbind (xy, z), cols=cols, lwd=2)
# add_colourbar (cols=terrain.colors (30), side=4, zlims=zl)
}

