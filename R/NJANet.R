#' NJA network class
#'
#' @description
#' The container of an NJA network.
#'
#' @concept R6
#'
NJANet <- R6Class(
  "NJANet",
  public = list(
    #' @field image The original image used for processing.
    image = NULL,
    #' @field skel A skeletonised version of the original image.
    skel = NULL,
    #' @field nodes The nodes of the network
    nodes = list(),
    #' @field edges The edges of the network
    edges = list(),
    #' @field incorrect_1nodes Nodes with 1 junc and more than 1 connected edge
    incorrect_1nodes = list(),

    #' @description
    #' Create a new NJANet object.
    #'
    #' @param image The original image used for processing.
    #' @param skel A skeletonised version of the original image.
    #' @param nodes The nodes of the network
    #' @param edges The edges of the network
    #' @param bordermat skel but with a 1 column and 1 row border of 0s.
    #' @param juncmat A map of the number of junctions that each cell has.
    #' @param adj_stack A 3D array containing the stack of adjacencies for each pixel.
    #'
    #' @returns A new [NJANet] object.
    initialize = function(image = NULL, skel = NULL, nodes = NULL, edges = NULL, bordermat = NULL, juncmat = NULL, adj_stack = NULL) {
      if (is.null(image) && is.null(skel)) {
        cli::cli_abort(c("x"="AT least one of {.arg image} or {.arg skel} must be filled."))
      }
      self$image = image
      self$skel = skel
      self$nodes = nodes %||% list()
      self$edges = edges %||% list()
      private$.bordermat = bordermat
      private$.juncmat = juncmat
      private$.adj_stack = adj_stack
    },

    #' @description
    #' Print an [NJANet] object.
    #'
    #' @param ... Unused.
    #'
    print = function(...) {
      cli::cli_text("NJANet: nodes = {length(self$nodes)}, edges = {length(self$edges)}")
      invisible(self)
    }
  ),
  private = list(
    # See sts2player for method for generating and caching these
    # self$image, but with a border
    .bordermat = NULL,
    .generate_bordermat = function() {
      private$.check_skel()
      private$.bordermat <- border_matrix(self$skel)
      return(private$.bordermat)
    },
    # A map of the number of junctions that each cell has.
    .juncmat = NULL,
    .generate_juncmat = function() {
      private$.check_skel()
      private$.juncmat <- map_junctions(self$skel, self$bordermat, self$adj_stack)
      return(private$.juncmat)
    },
    # The 3D stack of adjacencies (to be thought about and then implemented)
    .adj_stack = NULL,
    .generate_adj_stack = function() {
      private$.check_skel()
      private$.adj_stack <- find_adj_stack(self$skel, self$bordermat)
      return(private$.adj_stack)
    },
    # Whether the nodes have ever been linked before
    .nodes_ever_linked = FALSE,
    .check_skel = function(){
      if (is.null(self$skel)) {
        cli::cli_abort(c("x"="{.arg NJANet$skel} must be filled for this operation."))
      }
    }
  ),
  active = list(
    #' @field bordermat skel but with a 1 column and 1 row border of 0s.
    bordermat = function(value) {
      if (missing(value)) {
        private$.bordermat %||% private$.generate_bordermat()
      } else {
        cli::cli_abort(c("x"="{.arg $bordermat} is read only."))
      }
    },
    #' @field juncmat A map of the number of junctions that each cell has.
    juncmat = function(value) {
      if (missing(value)) {
        private$.juncmat %||% private$.generate_juncmat()
      } else {
        cli::cli_abort(c("x"="{.arg $juncmat} is read only."))
      }
    },
    #' @field adj_stack A 3D array containing the stack of adjacencies for each pixel.
    adj_stack = function(value) {
      if (missing(value)) {
        private$.adj_stack %||% private$.generate_adj_stack()
      } else {
        cli::cli_abort(c("x"="{.arg $adj_stack} is read only."))
      }
    }
  )
)
