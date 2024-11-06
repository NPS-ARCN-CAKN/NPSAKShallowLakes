#' GetLakeCoordinatesTable
#'
#' The GetLakeCoordinatesTable function returns a data frame of spatial coordinates in geographic coordinate system (Lat/Lon) for a shallow lakes monitoring lake .
#' @param Lake Lake for which spatial coordinates should be returned.
#' @return A data frame of coordinates for Lake.
#' @examples
#' # Get a data frame of spatial coordinates for Lake YUCH-004
#' LakeCoordinates = GetLakeCoordinatesTable('YUCH-004')
#' head(LakeCoordinates)
#' @export
GetLakeCoordinatesTable = function(Lake){

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    #Connect to the AK_ShallowLakes database
    Connection = GetDatabaseConnection()

    # Get the data using the odbc method
    Sql = paste("SELECT PONDNAME
,CASE WHEN M_LAT_WGS84 IS NULL And M_LAT_NAD83 IS NOT NULL THEN M_LAT_NAD83 ELSE M_LAT_WGS84 END As Lat
,CASE WHEN M_LON_WGS84 IS NULL And M_LON_NAD83 IS NOT NULL THEN M_LON_NAD83 ELSE M_LON_WGS84 END As Lon
, M_ELEVATION
FROM tblMonuments
WHERE (PONDNAME = '",Lake,"')",sep="")

    # Execute the query into a data frame
    DF = odbc::dbGetQuery(Connection,Sql)
    return(DF)
  }, warning = function(w) {

    # Warning
    message("Warning: ", conditionMessage(w))
    return(NA)

  }, error = function(e) {

    # Error
    message("Error: ", conditionMessage(e))
    return(NA)

  })


}



