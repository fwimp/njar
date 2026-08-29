#' Load an image into njar
#'
#' @description
#' Load an image and optionally skeletonize it.
#'
#' If you have already skeltonized the image externally, use [load_skel()].
#'
#'
#' @param p The path to a binary map to load.
#' @param skeletonize Whether to skeletonize the image using scikit-image through the reticulate package.
#' @param return_matrix Whether to return the image as a matrix.
#'
#' @section Binary image requirements:
#' The provided image should be in .png, .jpg, or .bmp format.
#'
#' Fully white pixels should indicate places where the network is present.
#'
#' @returns An [NJANet] object or `matrix` containing the image data.
#'
#' @examplesIf interactive()
#' load_image("path/to/image.png")
#'
#' @export
load_image <- function(p, skeletonize = TRUE, return_matrix = FALSE) {
  ext <- tolower(utils::tail(strsplit(p, "\\.")[[1]], 1))
  if (!(ext %in% c("png", "jpg", "jpeg", "bmp"))) {
    cli::cli_abort(c("x" = "Cannot currently load images aside from the following: .png, .jpg, .bmp"))
  }
  img <- imager::load.image(p)
  img <- img[,,1,1]
  skelimg <- img
  if (skeletonize) {
    # skimage should only load if skeletonization is required
    reticulate::py_require("scikit-image")
    skimage <- reticulate::import("skimage")
    skelimg <- reticulate::py_to_r(skimage$morphology$skeletonize(img))
  }
  if (return_matrix) {
    return(skelimg)
  } else if (!skeletonize) {
    cli::cli_warn("Cannot create an {.cls NJANet} object without skeletonization. Returning only the matrix.")
    return(skelimg)
  }
  return(NJANet$new(image = img, skel = skelimg))
}

#' Load a pre-skeletonized image into njar
#'
#' @description
#' Load an image that has already been skeletonized
#'
#' If you have a non-skeletonized image, use [load_image()].
#'
#' @param p The path to a binary map to load.
#' @param return_matrix Whether to return the image as a matrix.
#' @param orig_image (optional) The original image used to generate the skeleton.
#'
#' @section Binary image requirements:
#' The provided image should be in .png, .jpg, or .bmp format.
#'
#' Fully white pixels should indicate places where the network is present.
#'
#' @returns An [NJANet] object or `matrix` containing the image data.
#'
#' @examplesIf interactive()
#' load_skel("path/to/skeleton.png")
#'
#' @export
load_skel <- function(p, return_matrix = FALSE, orig_image = NULL) {
  ext <- tolower(utils::tail(strsplit(p, "\\.")[[1]], 1))
  if (!(ext %in% c("png", "jpg", "jpeg", "bmp"))) {
    cli::cli_abort(c("x" = "Cannot currently load images aside from the following: .png, .jpg, .bmp"))
  }
  img <- imager::load.image(p)
  img <- img[,,1,1]

  if (return_matrix) {
    return(img)
  }
  return(NJANet$new(image = orig_image, skel = img))
}
