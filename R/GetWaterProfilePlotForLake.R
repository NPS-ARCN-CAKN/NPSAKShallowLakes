#' GetWaterProfilePlotForLake
#' The GetWaterProfilePlotForLake function returns a depth profile plot of temperature by sampling date for Lake.
#' @param Lake Name of the lake to profile.
#' @param Parameter Parameter to plot. Options 'Temperature','pH','DO','DO_PCT'. Anything else will cause a database error.
#' @return A depth profile plot of Parameter by sampling date for Lake.
#' @examples
#' # Example of use:
#' GetWaterProfilePlotForLake('BELA-033','DO_Pct')
#' GetWaterProfilePlotForLake('YUCH-004','Temperature')
#' @export
GetWaterProfilePlotForLake = function(Lake,Parameter){

  library(odbc)
  library(tidyverse)

  # Define allowed values
  AllowedParameters <- c('Temperature','pH','DO','DO_Pct')

  Parameter = match.arg(Parameter,AllowedParameters)

  # Append '_Mean' to Parameter for the SQL query below.
  ParameterName = paste(Parameter,"_Mean",sep="")

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    #Connect to the AK_ShallowLakes database
    Connection = GetDatabaseConnection()

    # Get water profile parameter by depth for the continuous water quality lake visits
      Sql = paste("SELECT PONDNAME, Convert(Date,SAMPLEDATE) As [Date], SAMPLEDEPTH * -1 As [Depth (m)]
,Month(SampleDate) as [Month]
,Case When Month(SampleDate) <= 7 Then 'Spring' Else 'Fall' End as Season
, SAMPLEDEPTH
, Temperature_Mean, Temperature_Min, Temperature_Max, Temperature_SD, Temperature_n
, pH_Mean, pH_Min, pH_Max, pH_SD, pH_n
, SpCond_Mean, SpCond_Min, SpCond_Max, SpCond_SD, SpCond_n
, DO_Mean, DO_Min, DO_Max, DO_SD, DO_n
, DO_Pct_Mean, DO_Pct_Min, DO_Pct_Max, DO_Pct_SD, DO_Pct_n
FROM Summary_WaterProfileStatisticsByLake
WHERE (PONDNAME = '",Lake,"')
ORDER BY PONDNAME, SAMPLEDATE, SAMPLEDEPTH",sep="")

    # Execute the query into a data frame
    DF = odbc::dbGetQuery(Connection,Sql)

    Plot = ggplot(DF) +
      geom_path(aes_string(x=ParameterName,y='`Depth (m)`',linetype = 'Date',color='Season'),na.rm=TRUE,size = 1) +
      #geom_text(aes(x=Temperature_Mean,y=`Depth (m)`,label = Temperature_Mean, vjust = 1, hjust = 1),na.rm=TRUE) +
      #ylim(min(DF$`Depth (m)`),0) + # Set the y-axis range
      scale_y_continuous(breaks = seq(min(DF$`Depth (m)`), 0, by = 0.5)) + # Set y-axis increments
      scale_color_manual(values = c("Spring" = "darkolivegreen3", "Fall" = "tomato3")) +
      theme_minimal() +
      labs( title = paste(Lake," Depth Profile: ",Parameter,sep="")
            ,x = Parameter
            ,y = "Depth (m)"
            #,caption = paste("Figure X. Lake Depth Profile: ",Parameter,sep="") # Puts a figure caption below the figure, but I reconsidered, thinking it was better to let the package user put the caption where they want, saying what they want.
      )
      #ggtitle()

    return(Plot)

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
