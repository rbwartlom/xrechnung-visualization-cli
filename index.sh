#!/usr/bin/env bash

set -eou pipefail

invoice_path=$1

output_path=$2

# make the output path absolute
if [ "$output_path" != "null" ]; then   
    output_path="$(pwd)/$output_path"
fi

# path definitions for the script
script_dir="$(realpath "$(dirname "$0")")"
workdir=$(mktemp -d) # a temporary directory, located in RAM
trap 'rm -rf "$workdir"' EXIT # cleanup

# Determine invoice type automatically
if grep -q "urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" "$invoice_path"; then
    invoice_type="ubl_creditnote"
elif grep -q "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" "$invoice_path"; then
    invoice_type="ubl_invoice"
elif grep -q "urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" "$invoice_path"; then
    invoice_type="uncefact"
else
    echo "Unknown invoice type"
    exit 1
fi

echo "Detected invoice type: $invoice_type"

# load things into workfir to execute the ant script
cp "$script_dir/build_template.xml" "$workdir/build.xml"
mkdir "$workdir/input"
cp "$invoice_path" "$workdir/input/."



case "$invoice_type" in
    "ubl_creditnote")
    xr_xsl="ubl-creditnote-xr.xsl"
    ;;

    "ubl_invoice")
    xr_xsl="ubl-invoice-xr.xsl"
    ;;
    
    "uncefact")
    xr_xsl="cii-xr.xsl"
    ;;
esac

declare -a expression=(
    "s|{{basedir}}|$workdir|g"
    "s|{{lib_dir}}|$script_dir/lib|g"
    "s|{{build_dir}}|$script_dir/build|g"
    "s|{{xrechnung_viz_dir}}|$script_dir/xrechnung-visualization|g"
    "s|{{xr_xsl}}|$xr_xsl|g"
)

for expr in "${expression[@]}"; do
    sed -i '' -e "$expr" "$workdir/build.xml"
done

cd "$workdir" && ant transform-xr-to-pdf

if [[ "$output_path" != *.pdf ]]; then
    output_path="${output_path}.pdf"
fi
pdf_files=("$workdir/output/"*.pdf)
if [[ -f "${pdf_files[0]}" ]]; then
    cp "${pdf_files[0]}" "$output_path"
fi
