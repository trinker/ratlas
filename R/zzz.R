# nocov start
.onLoad <- function(libname, pkgname) {
  pdfFonts <- grDevices::pdfFonts()
  postscriptFonts <- grDevices::postscriptFonts()
  if (.Platform$OS.type == "windows") {
    windowsFonts <- grDevices::windowsFonts()
  }
}

.onAttach <- function(libname, pkgname) {
  if (.Platform$OS.type == "windows") {
    if (interactive()) {
      packageStartupMessage("Registering Windows fonts with R")
    }
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (getOption("ratlas.loadfonts", default = FALSE)) {
    if (interactive()){
      packageStartupMessage("Registering PDF & PostScript fonts with R")
    }
    extrafont::loadfonts("pdf", quiet = TRUE)
    extrafont::loadfonts("postscript", quiet = TRUE)
  }

  fnt <- extrafont::fonttable()
  if (!any(grepl("Arial[ ]Narrow|Montserrat", fnt$FamilyName))) {
    packageStartupMessage("NOTE: Either Arial Narrow or Montserrat fonts are required to use these themes.")
    packageStartupMessage("      Please use ratlas::import_montserrat() to install Montserrat and")
    packageStartupMessage("      if Arial Narrow is not on your system, please see https://bit.ly/arialnarrow")
  }
}
# nocov end