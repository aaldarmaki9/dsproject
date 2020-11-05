#' @title Import Function
#'
#' @description
#'
#' \code{import} reads in a dataframe from a file.
#'
#' @details
#' This function imports a data frame from a data file using a filename, or prompt
#' the user to choose a file without the need to provide a filename.
#'
#' @param file a character string of the file.
#' @param ... Additional arguments passed to the underlying import functions.
#' For example, this can control column classes for delimited file types,
#' or control the use of haven for Stata and SPSS or readxl for Excel (.xlsx) format.
#' @importFrom haven read_sas read_stata read_spss
#' @importFrom readxl read_excel
#' @importFrom vroom vroom
#' @export
#' @return return a dataframe.
#' @author Ahmed Aldarmaki <aaldarmaki@@wesleyan.edu>
#' @seealso [read_sas](https://www.rdocumentation.org/packages/haven/versions/2.3.1/topics/read_sas), [read_stata](https://www.rdocumentation.org/packages/haven/versions/2.3.1/topics/read_dta), [read_spss](https://www.rdocumentation.org/packages/haven/versions/2.3.1/topics/read_spss), [read_excel](https://www.rdocumentation.org/packages/readxl/versions/1.3.1/topics/read_excel), [vroom](https://www.rdocumentation.org/packages/vroom/versions/1.0.2/topics/vroom).
#' @examples
#' \dontrun{df <- import("datasetexample.xlsx")}
#' \dontrun{df <- import("datasetexample.xlsx", col_names=TRUE)}
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

