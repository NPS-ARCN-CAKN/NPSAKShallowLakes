#' GetDatabaseConnection()
#'
#' This function returns and odbc database connection to the AK_ShallowLakes database. This function is mostly used internally by other functions in the NPSShallowLakes package, but you can use it as part of your own database queries.
#' @return An odbc database connection object.
#' @examples
#' # Get a connection to the AK_ShallowLakes database
#' Connection = GetDatabaseConnection()
#' # Execute the query into a data frame
#' data = odbc::dbGetQuery(Connection,'SELECT Top 3 PONDNAME FROM tblPonds')
#' head(data)
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
