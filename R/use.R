#' @title Loading/Attaching of Packages
#'
#' @description
#' \code{use} loads and attaches add-on packages.
#'
#' @details
#' This function loads the namespace of the package with name \code{pkg} and attach it on the search list.
#' If package is not installed, it asks if you want to install it, and if yes loads/attaches the package.
#' Else, it returns a message.If the package does not exists, it returns FALSE and gives a warning. It checks
#' and updates the list of currently attached packages and do not reload a namespace which is already loaded.
#'
#'
#' @param pkg the name of a package, given as a name or literal character string.
#' @export
#' @return NULL
#' @author Ahmed Aldarmaki <aaldarmaki@@wesleyan.edu>
#' @examples
#' \dontrun{use(dplyr)}
#' \dontrun{use("dplyr")}

use <- function(pkg) {
  pkg <- as.character(substitute(pkg))
  if (!suppressWarnings(require(pkg, character.only = TRUE))) {
    msg <- paste("Install package", pkg, "(y/n)? ")
    answer <- readline(msg)
    answer <- substr(tolower(trimws(answer)), 1, 1)
    if (answer == "y") {
      install.packages(pkg)
      require(pkg, character.only = TRUE)
    } else {
      msg <- paste("Package", pkg, "not loaded.")
      message(msg)
    }
  }
}


