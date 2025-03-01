# XRechnung CLI
A lightweight command line interface for using the [xrechnung-visualization](https://github.com/itplr-kosit/xrechnung-visualization) library.

## Usage
When cloning this repository, make sure to clone with the `--recurse-submodules` flag to get the submodule as well.

The `index.sh` script is the entry point for the CLI. It provides the following arguments
- positional arguments
  - `input` - the path to the input file
  - `output` - the path to the output file
That's it, the script should take care of the rest!

## Repo Structure
- `index.sh` - The Script that the is CLI
- `xrechnung-visualization` - The xrechnung-visualization library as a submodule
- `build_template.xml` - The template for the build file, [source](https://github.com/DAtek/xrechnung-visualization-issues/blob/master/src/build_template.xml)
- `README.md` - This file