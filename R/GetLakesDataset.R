#' GetLakesDataset
#'
#' Queries the [tblPonds] database table and returns the records as a data frame.
#' @return A data frame of Lakes data.
#' @examples
#' # Example of use:
#' data = GetLakesDataset()
#' head(data)
#' @export
GetLakesDataset = function(){

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    #Connect to the AK_ShallowLakes database
    Connection = GetDatabaseConnection()

    # Get the data using the odbc method
    Sql = "SELECT [PONDNAME]
,[PARK]
,[LATITUDE_NAD83]
,[LONGITUDE_NAD83]
,[LATITUDE_WGS84]
,[LONGITUDE_WGS84]
,[ACCESSTYPE]
,[ELEVATION]
,[ELEVATION_NUM]
,[ELEVATIONSOURCE]
,[HYDROLOGIC_REGIME]
,[HYDROLOGIC_CLASS]
,[LOC_NOTES]
,[LOC_TYPE]
,[LOC_MATERIAL]
,[GRTS_NUM]
,[MAPLAKENUM]
,Convert(varchar(1000),[SITESELECTIONNOTES]) as SITESELECTIONNOTES
,[CONTINUOUS_DATA]
,[SALINITY]
,[EMERGENTS]
,[GENESIS]
,[ISLANDS]
,[SHORELINE]
,[SUBSTRATE_TEXTURE]
,[COMMENTS]
,[ECOREGION]
,[SUBSECTION]
,[DETSUBCODE]
,[LAKEGEOLOGY]
,[LAKEGEOLOGYNOTES]
,[LAKETYPE]
,[LAKTYPE_CONFIRM]
,[LAKETYPE_FIELDNOTES]
,[DENA_LAKETYPE]
,[FIREHISTORY]
,[PERMAFROST]
  FROM [AK_ShallowLakes].[dbo].[tblPonds]
  ORDER BY PONDNAME"

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
