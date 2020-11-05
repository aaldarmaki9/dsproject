#' @title Make Project
#' @description
#' This function will create all of the scaffolding for a new project.
#' It will set up all of the relevant directories and their initial contents.
#'
#' @details
#'
#' @param project the name of the project, given as a name or character string.
#' @param path the path of where the project should be created, the default is the current working directory.
#' @param folders a character vector of the folders created in the project.
#' @param readme creates a README text file that introduces and explains the project being created.
#' @param git a boolean value indicating whether to initialise a Git repository
#' and add important files to .gitignore.
#' @import usethis
#' @export
#' @return No value is returned; this function is called for its side effects.
#' @examples
#' # ADD_EXAMPLES_HERE
make_project <- function (project,
                  path = getwd(),
                  folders = c("figures", "documentation",
                              "data", "reports", "R"),
                  readme = "README.md",
                  git = FALSE) {


  # change to path location
  if(!dir.exists(path)) stop("No such path")
  setwd(path)

  # project directory
  if(!missing(project)) {
    dir.create(project)
    setwd(project)
  }

  # create subdirectories
  for (i in folders){
    dir.create(i)
  }


  # create README.md
  today <- Sys.Date()
  user  <- Sys.info()[["user"]]
  project <- basename(getwd())
  cat("# Project: ", project, "\n\n",
      "## Author: ", user, "\n\n",
      "## Date: ",   format(today, format="%B %d %Y"), "\n\n",
      "## Purpose: \n\n",
      "## Data Sources: \n\n",
      "## Stakeholders: \n\n",
      file = readme,
      sep = "")

  # create RStudio project
  usethis::create_project(".", open=FALSE)

  # add git
  if (git){
     usethis::use_git()
  }


  # activate project
  usethis::proj_activate(".")

}

