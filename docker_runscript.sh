#!/bin/bash

if [ "$#" -ne 3 ]; then # also catches -h and --help
    echo "Usage: $0 <docker_tag> <input_invoice_path> <output_pdf_path>"
    exit 1
fi

# Get the absolute paths for input and output
docker_tag=$1
input_path=$(realpath "$2")
output_path=$(realpath "$(dirname "$3")")/$(basename "$3")

docker run --rm \
    -v "$(dirname "$input_path"):/invoices" \
    -v "$(dirname "$output_path"):/app/output" \
    "$docker_tag" \
    "/invoices/$(basename "$input_path")" \
    "/output/$(basename "$output_path")"