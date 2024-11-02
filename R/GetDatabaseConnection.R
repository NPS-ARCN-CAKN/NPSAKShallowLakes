#' GetDatabaseConnection()
#' This function builds a database connection to the AK_ShallowLakes database.
#' @return An odbc database connection object.
#' @examples
#' Connection = GetDatabaseConnection()    MyDataFrame = odbc::dbGetQuery(Connection,'SELECT Top 3 * FROM tblPonds')
#' @export
GetDatabaseConnection <- function() {

  library(odbc)

  # Try to open a database connection to the AK_ShallowLakes database
  Connection <- tryCatch({

    # Get a database connection
    dbConnect(odbc(),Driver = "Sql Server",Server = "inpyugamsvm01\\nuna",Database = "AK_ShallowLakes")

  }, warning = function(w) {

    # Warning
    message("Warning: ", conditionMessage(w))
    return(NA)

  }, error = function(e) {

    # Error
    message("Error: ", conditionMessage(e))
    return(NA)

  }, finally = {

    # Finally
    # message("Cleanup, if needed")

  })

  return(Connection)
}
