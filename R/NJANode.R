#' NJA node class
#'
#' @description
#' A node in the NJA graph. Make a new one with `NJANode$new()`
#'
#' @concept R6
#'
NJANode <- R6Class(
  "NJANode",
  public = list(
    #' @field pos The position of the node.
    pos = c(),
    #' @field surround A 3x3 array indicating the pixel context of the node.
    surround = NULL,
    #' @field juncs The number of junctions the node has.
    juncs = NULL,
    #' @field dirs The directions that junctions of the node emit.
    dirs = NULL,
    #' @field uid A string of the position, acting as a unique identifier.
    uid = "",
    #' @field connected_edges A named list of all connected edges.
    connected_edges = list(),

    #' @description
    #' Create a new NJANode object.
    #'
    #' @param pos The position of the node.
    #' @param surround A 3x3 array indicating the pixel context of the node.
    #' @param juncs The number of junctions the node has.
    #' @param dirs The directions that junctions of the node emit.
    #' @param uid A string of the position, acting as a unique identifier.
    #'
    #' @returns A new [NJANode] object.
    initialize = function(pos, surround = NULL, juncs = NULL, dirs = NULL, uid = NULL) {
      self$pos <- as.integer(pos)
      self$uid = uid %||% paste0("(",pos[1],",",pos[2],")")
      # juncs, surround, and dirs are probably not needed
      self$surround = surround
      self$juncs = juncs
      self$dirs = dirs
    },

    #' @description
    #' Print an [NJANode] object.
    #'
    #' @param ... Unused.
    #'
    print = function(...) {
      cli::cli_text("NJANode: {self$uid}")
      invisible(self)
    }
  )
)
