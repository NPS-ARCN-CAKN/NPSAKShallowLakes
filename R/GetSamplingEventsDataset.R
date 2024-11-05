#' GetSamplingEventsDataset
#' Queries the [tblEvents] database table and returns the records as a data frame. This table contains information about each lake's sampling visit.
#' @return A data frame of Lakes data.
#' @examples
#' # Example of use:
#' data = GetSamplingEventsDataset()
#' head(data)
#' @export
GetSamplingEventsDataset = function(){

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    #Connect to the AK_ShallowLakes database
    Connection = GetDatabaseConnection()

    # Get the data using the odbc method
    Sql = "SELECT PONDNAME, Convert(Date,SAMPLEDATE) As SAMPLEDATE, YEAR, CONTMONVISIT, SAMPLEMETHOD, OBSERVERS, SECCHIDEPTH, SECCHINOTES, SECCHIONBOTTOM, ISSHOREBURNED, BURNNOTES, BURNDATE, THERMOKARSTEVIDENCE,
 THERMOKARSTLOCATION, THERMOKARSTEXTENT, THERMOKARSTACTIVE, THERMOKARSTMATERIAL, WOODFROGPRESENT, PERCENTCLOUDS, WIND, PRECIPITATION, PRECIPITATIONINTENSITY, WEATHERCOMMENTS,
 SITECONDITIONSCOMMENTS, BIRD_ANIMAL_ACTIVITY, UPLAND_VIERECK_CLASS, EMERGENT_VIERECK_CLASS, SUBMERGENT_VIERECK_CLASS, SUBMERGENT_COVER, ELODEA_SURVEYED, ELODEA_PRESENT,
 ELODEA_NOTES, FISHPRESENT, WL_L_TO_S, WL_L_TO_G, WATERLEVEL_CM, MON_MOVED, LAKE_LEVEL_NOTES, STRATCLASS, TURBIDITY_FIELD, EMERGENT_WIDTH, SUBMERGENT_WIDTH, LOONSPRESENT,
 RUSTYBBIRDSPRESENT, SDI, LAKEVOLUME_GIS_M3, LAKEAREA_GIS_M2, RecordInsertedDate, RecordInsertedBy, RecordUpdatedDate, RecordUpdatedBy
FROM    tblEvents
ORDER BY PONDNAME, SAMPLEDATE"

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
