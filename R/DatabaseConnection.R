#' Global: Build a database connection to the AK_ShallowLakes database.
#'
#' @export
Connection = dbConnect(odbc(),Driver = "Sql Server",Server = "inpyugamsvm01\\nuna", Database = "AK_ShallowLakes")
