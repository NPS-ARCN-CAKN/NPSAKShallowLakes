
#' GetLakeMap
#'
#' Function to retrieve the spatial coordinates of Lake from the AK_ShallowLakes:tblMonuments table and display them in a Leaflet map.
#' @param Lake Lake for which spatial coordinates should be returned
#' @return A Leaflet map for Lake.
#' @examples
#' # Get a Leaflet map showing Lake YUCH-004
#' GetLakeMap('YUCH-004')
#' @export
GetLakeMap = function(Lake){

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
    DF = odbc::dbGetQuery(Connection,Sql)

    # Map the units in Leaflet
    map = leaflet() %>%
      # Set the view and zoom levels
      setView(lng = DF$Lon, lat = DF$Lat, zoom = 10) %>%
      # Add WMS tiles
      addWMSTiles('https://basemap.nationalmap.gov:443/arcgis/services/USGSTopo/MapServer/WmsServer',layers = "0",options = WMSTileOptions(format = "image/png")) %>%

      # Label the units
      addLabelOnlyMarkers(~Lon,~Lat, label = ~PONDNAME, data = DF,  labelOptions = labelOptions(noHide = TRUE))

    return(map)

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










