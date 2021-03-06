
# This file is automatically generated, you probably don't want to edit this

dichotomousOptions <- if (requireNamespace('jmvcore')) R6::R6Class(
    "dichotomousOptions",
    inherit = jmvcore::Options,
    public = list(
        initialize = function(
            vars = NULL,
            ggm = FALSE, ...) {

            super$initialize(
                package='seolmatrix',
                name='dichotomous',
                requiresData=TRUE,
                ...)

            private$..vars <- jmvcore::OptionVariables$new(
                "vars",
                vars,
                suggested=list(
                    "continuous"),
                permitted=list(
                    "numeric"))
            private$..ggm <- jmvcore::OptionBool$new(
                "ggm",
                ggm,
                default=FALSE)

            self$.addOption(private$..vars)
            self$.addOption(private$..ggm)
        }),
    active = list(
        vars = function() private$..vars$value,
        ggm = function() private$..ggm$value),
    private = list(
        ..vars = NA,
        ..ggm = NA)
)

dichotomousResults <- if (requireNamespace('jmvcore')) R6::R6Class(
    inherit = jmvcore::Group,
    active = list(
        instructions = function() private$.items[["instructions"]],
        matrix = function() private$.items[["matrix"]],
        plot = function() private$.items[["plot"]]),
    private = list(),
    public=list(
        initialize=function(options) {
            super$initialize(
                options=options,
                name="",
                title="Tetrachoric Correlation")
            self$add(jmvcore::Html$new(
                options=options,
                name="instructions",
                title="Instructions",
                visible=TRUE,
                refs="seolmatrix"))
            self$add(jmvcore::Table$new(
                options=options,
                name="matrix",
                title="Tetrachoric Correlation",
                rows="(vars)",
                refs="psych",
                columns=list(
                    list(
                        `name`=".name[r]", 
                        `title`="", 
                        `type`="text", 
                        `content`="($key)", 
                        `combineBelow`=TRUE),
                    list(
                        `name`=".stat[r]", 
                        `title`="", 
                        `type`="text", 
                        `content`="r"))))
            self$add(jmvcore::Image$new(
                options=options,
                name="plot",
                title="Gaussian Graphical Model",
                width=500,
                height=500,
                renderFun=".plot",
                visible="(ggm)",
                refs="qgraph"))}))

dichotomousBase <- if (requireNamespace('jmvcore')) R6::R6Class(
    "dichotomousBase",
    inherit = jmvcore::Analysis,
    public = list(
        initialize = function(options, data=NULL, datasetId="", analysisId="", revision=0) {
            super$initialize(
                package = 'seolmatrix',
                name = 'dichotomous',
                version = c(1,0,0),
                options = options,
                results = dichotomousResults$new(options=options),
                data = data,
                datasetId = datasetId,
                analysisId = analysisId,
                revision = revision,
                pause = NULL,
                completeWhenFilled = FALSE,
                requiresMissings = FALSE)
        }))

#' Tetrachoric Correlation
#'
#' 
#' @param data The data as a data frame.
#' @param vars .
#' @param ggm .
#' @return A results object containing:
#' \tabular{llllll}{
#'   \code{results$instructions} \tab \tab \tab \tab \tab a html \cr
#'   \code{results$matrix} \tab \tab \tab \tab \tab correlation matrix table \cr
#'   \code{results$plot} \tab \tab \tab \tab \tab an image \cr
#' }
#'
#' Tables can be converted to data frames with \code{asDF} or \code{\link{as.data.frame}}. For example:
#'
#' \code{results$matrix$asDF}
#'
#' \code{as.data.frame(results$matrix)}
#'
#' @export
dichotomous <- function(
    data,
    vars,
    ggm = FALSE) {

    if ( ! requireNamespace('jmvcore'))
        stop('dichotomous requires jmvcore to be installed (restart may be required)')

    if ( ! missing(vars)) vars <- jmvcore::resolveQuo(jmvcore::enquo(vars))
    if (missing(data))
        data <- jmvcore::marshalData(
            parent.frame(),
            `if`( ! missing(vars), vars, NULL))


    options <- dichotomousOptions$new(
        vars = vars,
        ggm = ggm)

    analysis <- dichotomousClass$new(
        options = options,
        data = data)

    analysis$run()

    analysis$results
}
