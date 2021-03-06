% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api-package.R
\docType{package}
\name{drake-package}
\alias{drake-package}
\alias{drake}
\title{drake: A pipeline toolkit for reproducible computation at scale.}
\description{
drake is a pipeline toolkit
(\url{https://github.com/pditommaso/awesome-pipeline})
and a scalable, R-focused solution for reproducibility and high-performance computing.
}
\examples{
\dontrun{
test_with_dir("Quarantine side effects.", {
if (requireNamespace("knitr")) {
library(drake)
load_mtcars_example() # Get the code with drake_example("mtcars").
make(my_plan) # Build everything.
make(my_plan) # Nothing is done because everything is already up to date.
reg2 = function(d) { # Change one of your functions.
  d$x3 = d$x^3
  lm(y ~ x3, data = d)
}
make(my_plan) # Only the pieces depending on reg2() get rebuilt.
# Write a flat text log file this time.
make(my_plan, cache_log_file = TRUE)
# Read/load from the cache.
readd(small)
loadd(large)
head(large)
clean() # Restart from scratch.
make(my_plan, jobs = 2) # Distribute over 2 parallel jobs.
clean() # Restart from scratch.
# Parallelize over at most 4 separate R sessions.
# Requires Rtools on Windows.
# make(my_plan, jobs = 4, parallelism = "Makefile") # nolint
# Everything is already up to date.
# make(my_plan, jobs = 4, parallelism = "Makefile") # nolint
clean(destroy = TRUE) # Totally remove the cache.
unlink("report.Rmd") # Clean up the remaining files.
}
})
}
}
\references{
\url{https://github.com/ropensci/drake}
}
\author{
William Michael Landau \email{will.landau@gmail.com}
}
