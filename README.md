osmplotr
========

[![Build Status](https://travis-ci.org/mpadge/osmplotr.svg?branch=master)](https://travis-ci.org/mpadge/osmplotr) [![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/osmplotr?color=orange)](http://cran.r-project.org/package=osmplotr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/osmplotr)](http://cran.r-project.org/package=osmplotr)

![map1](./figure/map1.png)

R package to produce visually impressive customisable images of urban areas from OpenStreetMap (OSM) data, using data downloaded from the [overpass api](http://overpass-api.de/). The above map shows building polygons for a small portion of central London, U.K., and was made with the following easy steps:

1.  Specify the bounding box for the desired region

    ``` r
    bbox <- get_bbox (c(-0.15,51.5,-0.1,51.52))
    ```

2.  Download the desired data---in this case, all building perimeters.

    ``` r
    dat_B <- extract_osm_objects (key="building", bbox=bbox)$obj
    ```

3.  Initiate an `osm_basemap` with desired background (`bg`) colour

    ``` r
    plot_osm_basemap (bbox=bbox, bg="gray20", file="map1.png")
    ```

4.  Overlay objects on plot in the desired colour.

    ``` r
    add_osm_objects (dat_B, col="gray40")
    ```

5.  Close graphics device to finish

    ``` r
    graphics.off ()
    ```

Installation
------------

``` r
install.packages ('osmplotr')
```

or the development version

``` r
devtools::install_github ('mpadge/osmplotr')
```

A simple map
------------

Simple maps can be made by overlaying different kinds of OSM data in different colours:

``` r
dat_H <- extract_osm_objects (key="highway", bbox=bbox)$obj
dat_P <- extract_osm_objects (key="park", bbox=bbox)$obj
dat_G <- extract_osm_objects (key="landuse", value="grass", bbox=bbox)$obj
```

``` r
plot_osm_basemap (bbox=bbox, bg="gray20", file="map2.png")
add_osm_objects (dat_B, col="gray40")
add_osm_objects (dat_H, col="gray80")
add_osm_objects (dat_P, col="darkseagreen")
add_osm_objects (dat_G, col="darkseagreen1")
graphics.off ()
```

![map2](./figure/map2.png)

Highlighting selected areas
---------------------------

`osmplotr` is primarily intended as a data visualisation tool, particularly through enabling selected regions to be highlighted. Regions can be defined according to simple point boundaries:

``` r
pts <- sp::SpatialPoints (cbind (c (-0.128, -0.138, -0.138, -0.128),
                             c (51.502, 51.502, 51.515, 51.515)))
```

and OSM objects within the defined regions highlighted with different colour schemes. The `col_extra` parameter defines the colour of the remaining, background area.

``` r
plot_osm_basemap (bbox=bbox, bg="gray20", file="map3.png")
add_osm_groups (dat_B, groups=pts, col="orange", col_extra="gray40", 
                   colmat=FALSE, boundary=1)
add_osm_objects (london$dat_P, col="darkseagreen1")
add_osm_groups (london$dat_P, groups=pts, col='darkseagreen1',
                   col_extra='darkseagreen', colmat=FALSE, boundary=0)
graphics.off ()
```

![map3](./figure/map3.png)

Or may highlighted in dark-on-light:

``` r
plot_osm_basemap (bbox=bbox, bg="gray95", file="map4.png")
add_osm_groups (dat_B, groups=pts, col="gray40", col_extra="gray85",
                   colmat=FALSE, boundary=1)
add_osm_groups (dat_H, groups=pts, col="gray20", col_extra="gray70",
                   colmat=FALSE, boundary=0)
graphics.off ()
```

![map4](./figure/map4.png)

### Highlighting clusters

`add_osm_groups` also enables plotting an entire region as a group of spatially distinct clusters of defined colours. The argument `groups` in the following call is a list of `SpatialPoints` objects defining 12 small, spatially separated regions. Calling `add_osm_groups` with `col_extra=NA` (or `NULL`) forces all points lying outside those defined groups to be allocated to the nearest groups, and thus produces an inclusive grouping extending across an entire area.

``` r
plot_osm_basemap (bbox=bbox, bg='gray20', file='map5.png')
add_osm_groups (dat_B, groups=groups, col_extra=NA, make_hull=FALSE,
                   colmat=TRUE, lwd=3)
graphics.off ()
```

![map5](./figure/map5.png)

### Highlighting areas bounded by named highways

An alternative way of defining highlighted groups is by naming the highways encircling desired regions.

``` r
highways <- c ('Davies.St', 'Berkeley.Sq', 'Berkeley.St', 'Piccadilly',
               'Regent.St', 'Oxford.St')
highways1 <- highways2polygon (highways=highways, bbox=bbox)
highways <- c ('Regent.St', 'Oxford.St', 'Shaftesbury')
highways2 <- highways2polygon (highways=highways, bbox=bbox)
highways <- c ('Piccadilly', 'Shaftesbury.Ave', 'Charing.Cross.R',
               'Saint.Martin', 'Trafalgar.Sq', 'Cockspur.St',
               'Pall.Mall', 'St.James')
highways3 <- highways2polygon (highways=highways, bbox=bbox)
highways <- c ('Charing.Cross', 'Duncannon.St', 'Strand', 'Aldwych',
               'Kingsway', 'High.Holborn', 'Shaftesbury.Ave')
highways4 <- highways2polygon (highways=highways, bbox=bbox)
highways <- c ("Kingsway", "Holborn", "Farringdon.St", "Strand",
               "Fleet.St", "Aldwych")
highways5 <- highways2polygon (highways=highways, bbox=bbox)
groups <- list (highways1, highways2, highways3, highways4, highways5)
```

And then passing the SpatialPolygon returned by `highways2polygon` to `add_osm_groups`, this time with some Wes Anderson flair.

``` r
plot_osm_basemap (bbox=bbox, bg='gray20', file='map6.png')
library (wesanderson)
cols <- wes_palette ("Darjeeling", 5) 
add_osm_groups (dat_B, groups=groups, boundary=1,
                   col_extra='gray40', colmat=FALSE, col=cols)
add_osm_groups (dat_H, groups=groups, boundary=0,
                   col_extra='gray70', colmat=FALSE, col=cols)
graphics.off ()
```

![map6](./figure/map6.png)

See package vignettes ('Downloading Data' and 'Making Maps') for a lot more detail and further capabilities of `osmplotr`.

### Data surfaces

Finally, `osmplotr` contains a function `add_osm_surface` to spatially interpolate a given set of spatial data points and colour OSM objects according to a specified colour gradient. This is illustrated here with the `volcano` data projected onto the `bbox`.

``` r
x <- seq (bbox [1,1], bbox [1,2], length.out=dim (volcano)[1])
y <- seq (bbox [2,1], bbox [2,2], length.out=dim (volcano)[2])
xy <- cbind (rep (x, dim (volcano) [2]), rep (y, each=dim (volcano) [1]))
z <- as.numeric (volcano)
```

`add_osm_surface` returns the limits of the *interpolated* surface. These may differ from the original limits, and should be used to scale `add_colourbar`.

``` r
plot_osm_basemap (bbox=bbox, bg="gray20", file='map7.png')
zl <- add_osm_surface (dat_B, dat=cbind (xy, z), cols=terrain.colors (30))
cols <- adjust_colours (terrain.colors (30), -0.2) # Darken by ~20%
zl <- add_osm_surface (dat_H, dat=cbind (xy, z), cols=cols)
add_colourbar (cols=terrain.colors (30), side=4, zlims=zl)
graphics.off ()
```

![map7](./figure/map7.png)
