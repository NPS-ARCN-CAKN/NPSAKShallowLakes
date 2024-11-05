test_that("GetLakeCoordinatesTable returns a data frame", {
  result <- GetLakeCoordinatesTable('BELA-001')
  expect_s3_class(result, "data.frame")
})

test_that("GetLakeCoordinatesTable requires a Lake name as a string", {
  input <- "BELA-001"
  expect_type(Lake, "character")
})

