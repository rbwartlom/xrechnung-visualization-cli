# XRechnung CLI
A lightweight command line interface for using the [xrechnung-visualization](https://github.com/itplr-kosit/xrechnung-visualization) library. 

Built because just running the repo is unnecessarily complex. Also, a lot of the existing software ran on one specific programming langage (like PHP), which is obviously a pain to use if you're using anything else (e.g. Python or Typescript) and want to integrate in your project. This is why this small codebase is Dockerized and only uses bash beyond the requirements from `xrechnung-visualization`

## Usage
When cloning this repository, make sure to clone with the `--recurse-submodules` flag to get the submodule as well.

### CLI Arguments
- _`<docker_tag>` (docker mode only): The tag of the docker image to use._
- `<input_invoice_path>`: The path to the input invoice file.
- `<output_pdf_path>`: The path where the output PDF will be saved.

### Running on your own machine
This is faster, but there might be unforeseen dependency issues.
1. Make sure you have a JRE, `ant` and `xsltproc` installed
2. The `index.sh` script is the entry point for the CLI.
  ```bash
  ./index.sh <input_invoice_path> <output_pdf_path>
  ```

### Running with Docker
1. Build the Docker image
    ```bash
    docker build -t <docker_tag> .
    ```
2. The `docker_runscript.sh` script is the entry point for the CLI.
    ```bash
    ./docker_runscript.sh <docker_tag> <input_invoice_path> <output_pdf_path>
    ```


## Repo Structure
- `index.sh` - The Script that the is CLI
- `xrechnung-visualization` - The xrechnung-visualization library as a submodule
- `build_template.xml` - The template for the build file, [source](https://github.com/DAtek/xrechnung-visualization-issues/blob/master/src/build_template.xml)
- `README.md` - This file