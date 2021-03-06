% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api-read.R
\name{readd}
\alias{readd}
\alias{loadd}
\title{Read and return a drake target/import from the cache.}
\usage{
readd(target, character_only = FALSE, path = getwd(), search = TRUE,
  cache = drake::get_cache(path = path, search = search, verbose =
  verbose), namespace = NULL, verbose = 1L, show_source = FALSE)

loadd(..., list = character(0), imported_only = FALSE,
  path = getwd(), search = TRUE, cache = drake::get_cache(path =
  path, search = search, verbose = verbose), namespace = NULL,
  envir = parent.frame(), jobs = 1, verbose = 1L, deps = FALSE,
  lazy = "eager", graph = NULL, replace = TRUE,
  show_source = FALSE, tidyselect = TRUE, config = NULL)
}
\arguments{
\item{target}{If \code{character_only} is \code{TRUE}, then
\code{target} is a character string naming the object to read.
Otherwise, \code{target} is an unquoted symbol with the name of the
object.}

\item{character_only}{Logical, whether \code{name} should be treated
as a character or a symbol
(just like \code{character.only} in \code{\link[=library]{library()}}).}

\item{path}{Root directory of the drake project,
or if \code{search} is \code{TRUE}, either the
project root or a subdirectory of the project.
Ignored if a \code{cache} is supplied.}

\item{search}{Logical. If \code{TRUE}, search parent directories
to find the nearest drake cache. Otherwise, look in the
current working directory only.
Ignored if a \code{cache} is supplied.}

\item{cache}{drake cache. See \code{\link[=new_cache]{new_cache()}}.
If supplied, \code{path} and \code{search} are ignored.}

\item{namespace}{Optional character string,
name of the \code{storr} namespace to read from.}

\item{verbose}{Logical or numeric, control printing to the console.
\itemize{
\item \code{0} or \code{FALSE}: print nothing.
\item \code{1} or \code{TRUE}: print only targets to build.
\item \code{2}: plus checks and cache info.
\item \code{3}: plus missing imports.
\item \code{4}: plus all imports.
\item \code{5}: plus execution and total build times for targets.
\item \code{6}: plus notifications when targets are being stored.
}}

\item{show_source}{Logical, option to show the command
that produced the target or indicate that the object
was imported (using \code{\link[=show_source]{show_source()}}).}

\item{...}{Targets to load from the cache: as names (symbols) or
character strings. If the \code{tidyselect} package is installed,
you can also supply \code{dplyr}-style \code{tidyselect}
commands such as \code{starts_with()}, \code{ends_with()}, and \code{one_of()}.}

\item{list}{Character vector naming targets to be loaded from the
cache. Similar to the \code{list} argument of \code{\link[=remove]{remove()}}.}

\item{imported_only}{Logical, whether only imported objects
should be loaded.}

\item{envir}{Environment to load objects into. Defaults to the
calling environment (current workspace).}

\item{jobs}{Number of parallel jobs for loading objects. On
non-Windows systems, the loading process for multiple objects
can be lightly parallelized via \code{parallel::mclapply()}.
just set jobs to be an integer greater than 1. On Windows,
\code{jobs} is automatically demoted to 1.}

\item{deps}{Logical, whether to load any cached
dependencies of the targets
instead of the targets themselves.
This is useful if you know your
target failed and you want to debug the command in an interactive
session with the dependencies in your workspace.
One caveat: to find the dependencies,
\code{\link[=loadd]{loadd()}} uses information that was stored
in a \code{\link[=drake_config]{drake_config()}} list and cached
during the last \code{\link[=make]{make()}}.
That means you need to have already called \code{\link[=make]{make()}}
if you set \code{deps} to \code{TRUE}.}

\item{lazy}{Either a string or a logical. Choices:
\itemize{
\item \code{"eager"}: no lazy loading. The target is loaded right away
with \code{\link[=assign]{assign()}}.
\item \code{"promise"}: lazy loading with \code{\link[=delayedAssign]{delayedAssign()}}
\item \code{"bind"}: lazy loading with active bindings:
\code{bindr::populate_env()}.
\item \code{TRUE}: same as \code{"promise"}.
\item \code{FALSE}: same as \code{"eager"}.
}}

\item{graph}{Deprecated.}

\item{replace}{Logical. If \code{FALSE},
items already in your environment
will not be replaced.}

\item{tidyselect}{Logical, whether to enable
\code{tidyselect} expressions in \code{...} like
\code{starts_with("prefix")} and \code{ends_with("suffix")}.}

\item{config}{Optional \code{\link[=drake_config]{drake_config()}} object.
You should supply one if \code{deps} is \code{TRUE}.}
}
\value{
The cached value of the \code{target}.
}
\description{
\code{\link[=readd]{readd()}} returns an object from the cache,
and \code{\link[=loadd]{loadd()}} loads one or more objects from the cache
into your environment or session. These objects are usually
targets built by \code{\link[=make]{make()}}.
}
\details{
There are two uses for the
\code{\link[=loadd]{loadd()}} and \code{\link[=readd]{readd()}} functions:
\enumerate{
\item Exploring the results outside the \code{drake}/\code{make()} pipeline.
When you call \code{\link[=make]{make()}} to run your project,
\code{drake} puts the targets in a cache, usually a folder called \code{.drake}.
You may want to inspect the targets afterwards, possibly in an
interactive R session. However, the files in the \code{.drake} folder
are organized in a special format created by the
\href{https://github.com/richfitz/storr}{storr} package,
which is not exactly human-readable.
To retrieve a target for manual viewing, use \code{\link[=readd]{readd()}}.
To load one or more targets into your session, use \code{\link[=loadd]{loadd()}}.
\item In \code{knitr} / R Markdown reports.
You can borrow \code{drake} targets in your active code chunks
if you have the right calls to \code{\link[=loadd]{loadd()}} and \code{\link[=readd]{readd()}}.
These reports can either run outside the \code{drake} pipeline,
or better yet, as part of the pipeline itself.
If you call \code{knitr_in("your_report.Rmd")} inside a \code{\link[=drake_plan]{drake_plan()}}
command, then \code{\link[=make]{make()}} will scan \code{"your_report.Rmd"} for
calls to \code{loadd()} and \code{readd()} in active code chunks,
and then treat those loaded targets as dependencies.
That way, \code{\link[=make]{make()}} will automatically (re)run the report if those
dependencies change.
}
}
\note{
Please do not put calls to \code{\link[=loadd]{loadd()}} or \code{\link[=readd]{readd()}} inside
your custom (imported) functions or the commands in your \code{\link[=drake_plan]{drake_plan()}}.
This creates confusion inside \code{\link[=make]{make()}}, which has its own ways of
interacting with the cache.
}
\examples{
\dontrun{
test_with_dir("Quarantine side effects.", {
if (requireNamespace("knitr")) {
load_mtcars_example() # Get the code with drake_example("mtcars").
make(my_plan) # Run the project, build the targets.
readd(reg1) # Return imported object 'reg1' from the cache.
readd(small) # Return targets 'small' from the cache.
readd("large", character_only = TRUE) # Return 'large' from the cache.
# For external files, only the fingerprint/hash is stored.
readd(file_store("report.md"), character_only = TRUE)
}
})
}
\dontrun{
test_with_dir("Quarantine side effects.", {
if (requireNamespace("knitr")) {
load_mtcars_example() # Get the code with drake_example("mtcars").
make(my_plan) # Run the projects, build the targets.
config <- drake_config(my_plan)
loadd(small) # Load target 'small' into your workspace.
small
# For many targets, you can parallelize loadd()
# using the 'jobs' argument.
loadd(list = c("small", "large"), jobs = 2)
ls()
# Load the dependencies of the target, coef_regression2_small
loadd(coef_regression2_small, deps = TRUE, config = config)
ls()
# Load all the imported objects/functions.
loadd(imported_only = TRUE)
ls()
# Load all the targets listed in the workflow plan
# of the previous `make()`.
# Be sure your computer has enough memory.
loadd()
ls()
# With files, you just get the fingerprint.
loadd(list = file_store("report.md"))
ls() # Should include "\\"report.md\\"".
get(file_store("report.md"))
}
})
}
}
\seealso{
\code{\link[=cached]{cached()}}, \code{\link[=drake_plan]{drake_plan()}}, \code{\link[=make]{make()}}

\code{\link[=cached]{cached()}}, \code{\link[=drake_plan]{drake_plan()}}, \code{\link[=make]{make()}}
}
