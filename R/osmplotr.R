#' osmplotr.
#'
#' @name osmplotr
#' @docType package
#' @import RCurl sp spatstat spatialkernel osmar XML igraph ggm rgeos
NULL

#' london 
#'
#' A list of SpatialPolygonsDataFrames (SPDF) and SpatialLinesDataFrames (SLDF)
#' containing OpenStreetMap polygons and lines for various OpenStreetMap
#' structures in a small part of central London, U.K.  (bbox = -0.15, 51.5,
#' -0.1, 51.52). The list includes:
#' \enumerate{
#'  \item dat_H an SLDF of non-primary highways with 3,868 lines 
#'  \item dat_HP an SLDF of primary highways with 659 lines 
#'  \item dat_B an SPDF of non-commerical buildings with 6,177 polygons 
#'  \item dat_BC an SPDF of commerical buildings with 30 polygons 
#'  \item dat_A an SPDF of amenities with 1,157 polygons 
#'  \item dat_G an SPDF of grassed areas with 50 polygons 
#'  \item dat_P an SPDF of parks with 49 polygons 
#'  \item dat_N an SPDF of natural areas with 36 polygons 
#'  \item dat_RFH an SPDF containing 1 polygon representing Royal Festival Hall
#'  \item dat_ST an SPDF containing 1 polygon representing 150 Stamford Street
#' }
#'
#' @examples
#' \dontrun{
#' # Data were downloaded using the following code:
#' structures <- c ("highway", "highway", "building", "building", "building",
#'                  "amenity", "grass", "park", "natural", "tree")   
#' structs <- osm_structures (structures=structures, col_scheme="dark")   
#' structs$value [1] <- "!primary"   
#' structs$value [2] <- "primary"
#' structs$suffix [2] <- "HP"
#' structs$value [3] <- "!residential"
#' structs$value [4] <- "residential"
#' structs$value [5] <- "commercial"
#' structs$suffix [3] <- "BNR"
#' structs$suffix [4] <- "BR"
#' structs$suffix [5] <- "BC"
#' london <- list ()
#' for (i in 1:(nrow (structs) - 1)) {
#'     dat <- extract_osm_objects (key=structs$key [i], value=structs$value [i],
#'                                bbox=bbox)
#'     fname <- paste0 ("dat_", structs$suffix [i])
#'     assign (fname, dat)
#'     london [[i]] <- get (fname)
#'     names (london)[i] <- fname
#'     rm (list=c(fname))
#' }
#' extra_pairs <- c ("name", "Royal.Festival.Hall")
#' london$dat_RFH <- extract_osm_objects (key="building", extra_pairs=extra_pairs, 
#'                                 bbox=bbox)
#' extra_pairs <- list (c ("addr:street", "Stamford.St"),
#'                      c ("addr:housenumber", "150"))
#' london$dat_ST <- extract_osm_objects (key="building", extra_pairs=extra_pairs, 
#'                                 bbox=bbox)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name london
#' @format A list of spatial objects
NULL