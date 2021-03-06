#' get_bbox
#'
#' Converts a string of latitudes and longitudes into a square matrix to be
#' passed as a 'bbox' argument (to extract_osm_objects(), plot_osm_basemap (),
#' make_osm_map (), or extract_highway ()).
#'
#' @param latlon A vector of (longitude, latitude, longitude, latitude) values
#' @return A 2-by-2 matrix of 4 elements with columns of min and max values, and
#' rows of x and y values.  
#' @export
#'
#' @examples
#' bbox <- get_bbox (c (-0.15, 51.5, -0.1, 51.52))

get_bbox <- function (latlon)
{
    if (latlon [1] > latlon [3]) latlon [c (1, 3)] <- latlon [c (3, 1)]
    if (latlon [2] > latlon [4]) latlon [c (2, 4)] <- latlon [c (4, 2)]

    bbox <- matrix (latlon, nrow=2, ncol=2)
    rownames (bbox) <- c ("x", "y")
    bbox <- data.frame (bbox)
    names (bbox) <- c ("min", "max")
    as.matrix (bbox)
}
