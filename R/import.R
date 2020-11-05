#' @title Import Function
#'
#' @description
#'
#' \code{import} reads in a dataframe from a file.
#'
#' @details
#' This function imports a data frame or matrix from a data file
#' with the file format based on the file extension, and it also prompt
#' user to choose a file without the need to provide a filename.
#'
#' @param file a character string naming a file.
#' @param ... Additional arguments passed to the underlying import functions.
#' For example, this can control column classes for delimited file types,
#' or control the use of haven for Stata and SPSS or readxl for Excel (.xlsx) format.
#' @importFrom haven read_sas read_stata read_spss
#' @importFrom readxl read_excel
#' @importFrom vroom vroom
#' @export
#' @return return a dataframe.
#' @author Ahmed Aldarmaki <aaldarmaki@@wesleyan.edu>
#' @seealso \code{\link{read_sas}}, \code{\link{read_stata}}, \code{\link{read_spss}}, \code{\link{read_excel}}, \code{\link{vroom}}.
#' @examples
#' \dontrun{df <- import("datasetexample.xlsx")}
import <- function(file, ...){

  # if no file specified, prompt user

  if(missing(file))
    file <- file.choose()


  # get file info

  file <- tolower(file)
  basename <- basename(file)
  extension <- tools::file_ext(file)


  # import dataset

  df <- switch(extension,
           "sas7bdat" = haven::read_sas(file, ...),
           "dta" = haven::read_stata(file, ...),
           "sav" = haven::read_spss(file, ...),
           "xlsx" = readxl::read_excel(file, ...),
           "xls" = readxl::read_excel(file, ...),
           vroom::vroom(file, ...)
           )

  # return data frame
  return(df)
}


