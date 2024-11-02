#' WaterProfiles_GetDataSummary
#'
#' Queries the [AK_ShallowLakes].[dbo].[Summary_WaterProfileStatisticsByLake] view and returns the records as a data frame. Data is summarized over SAMPLENUMBER replicates by lake and date.
#' @return A data frame of water profile statistics for temperature, pH, and dissolved oxygen.
#' @examples
#' # Example of use:
#' WaterProfilesDataSummary = WaterProfiles_GetDataSummary
#' head(WaterProfilesDataSummary)
#' @export
WaterProfiles_GetDataSummary = function(){

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    #Connect to the AK_ShallowLakes database
    Connection = GetDatabaseConnection()

    # Get the data using the odbc method
    # Get water profile parameters by depth for the continuous water quality lake visits
      Sql = " SELECT [PONDNAME]
,[SAMPLEDATE]
,Month(SampleDate) as [Month]
,Case When Month(SampleDate) < 7 Then 'Spring' Else 'Fall' End as Season
,[SAMPLEDEPTH]
,[Temperature_Mean]
,[Temperature_Min]
,[Temperature_Max]
,[Temperature_SD]
,[Temperature_n]
,[pH_Mean]
,[pH_Min]
,[pH_Max]
,[pH_SD]
,[pH_n]
,[SpCond_Mean]
,[SpCond_Min]
,[SpCond_Max]
,[SpCond_SD]
,[SpCond_n]
,[DO_Mean]
,[DO_Min]
,[DO_Max]
,[DO_SD]
,[DO_n]
,[DO_Pct_Mean]
,[DO_Pct_Min]
,[DO_Pct_Max]
,[DO_Pct_SD]
,[DO_Pct_n]
FROM [AK_ShallowLakes].[dbo].[Summary_WaterProfileStatisticsByLake]
ORDER BY PONDNAME,SAMPLEDATE,SAMPLEDEPTH"

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
