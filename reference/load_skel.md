# Load a pre-skeletonized image into njar

Load an image that has already been skeletonized

If you have a non-skeletonized image, use
[`load_image()`](https://fwimp.github.io/njar/reference/load_image.md).

## Usage

``` r
load_skel(p, return_matrix = FALSE, orig_image = NULL)
```

## Arguments

- p:

  The path to a binary map to load.

- return_matrix:

  Whether to return the image as a matrix.

- orig_image:

  (optional) The original image used to generate the skeleton.

## Value

An [NJANet](https://fwimp.github.io/njar/reference/NJANet.md) object or
`matrix` containing the image data.

## Binary image requirements

The provided image should be in .png, .jpg, or .bmp format.

Fully white pixels should indicate places where the network is present.

## Examples

``` r
if (FALSE) { # interactive()
load_skel("path/to/skeleton.png")
}
```
