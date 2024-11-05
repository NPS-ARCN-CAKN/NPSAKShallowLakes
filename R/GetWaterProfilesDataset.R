#' GetWaterProfilesDataset
#'
#' Queries the [AK_ShallowLakes].[dbo].[tblWaterProfiles] database table and returns the records as a data frame.
#' @return A data frame of water profile data.
#' @examples
#' # Example of use:
#' data = GetWaterProfilesDataset()
#' head(data)
#' @export
GetWaterProfilesDataset = function(){

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    #Connect to the AK_ShallowLakes database
    Connection = GetDatabaseConnection()

    # Get the data using the odbc method
    # Get water profile parameters by depth for the continuous water quality lake visits
    Sql = "SELECT PONDNAME, CONVERT(Date, SAMPLEDATE) AS SAMPLEDATE, SAMPLENUMBER, SAMPLEDEPTH, DEPTH_SENSORCALC, DEPTH_VERTICAL_RAW_m, TEMPERATURE, PH, pH_mV, SPECIFICCONDUCTANCE, DO, DO_PCT,
ODO_PCT_LOCALB, DO_METHOD, DO_Charge, PROFILE_COMMENTS, SAMPLETIME, RecordInsertedDate, RecordInsertedBy, RecordUpdatedDate, RecordUpdatedBy, row_timestamp
FROM tblWaterProfiles"

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
