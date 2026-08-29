# Load an image into njar

Load an image and optionally skeletonize it.

If you have already skeltonized the image externally, use
[`load_skel()`](https://fwimp.github.io/njar/reference/load_skel.md).

## Usage

``` r
load_image(p, skeletonize = TRUE, return_matrix = FALSE)
```

## Arguments

- p:

  The path to a binary map to load.

- skeletonize:

  Whether to skeletonize the image using scikit-image through the
  reticulate package.

- return_matrix:

  Whether to return the image as a matrix.

## Value

An [NJANet](https://fwimp.github.io/njar/reference/NJANet.md) object or
`matrix` containing the image data.

## Binary image requirements

The provided image should be in .png, .jpg, or .bmp format.

Fully white pixels should indicate places where the network is present.

## Examples

``` r
if (FALSE) { # interactive()
load_image("path/to/image.png")
}
```
