#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="integration-guidance/api-reference"
TEMPLATE="$SCRIPT_DIR/gen-doc-template.tmpl"
PROTO_DIR="$PROJECT_DIR/proto"

# Convention: proto file path -> md slug
# Strip "tzero/v1/" or "ivms101/v1/" prefix, replace "/" with "_", drop ".proto"
proto_to_slug() {
    local path="$1"
    path="${path#tzero/v1/}"
    path="${path#ivms101/v1/}"
    path="${path//\//_}"
    path="${path%.proto}"
    echo "$path"
}

# Replicate protoc-gen-doc's anchor filter: "/" -> "_", other special chars -> "-"
anchor_filter() {
    local str="$1"
    str="${str//\//_}"
    echo "$str" | sed 's/[^a-zA-Z0-9_-]/-/g'
}

escape_sed() {
    printf '%s' "$1" | sed 's/[&|\\]/\\&/g'
}

# Pages to generate: "proto_file|title|weight"
PAGES=(
    "tzero/v1/common/common.proto|Common|338"
    "tzero/v1/common/payment_method.proto|Payment Method|337"
    "tzero/v1/common/payment_receipt.proto|Payment Receipt|336"
    "tzero/v1/payment/network.proto|Payment Network|331"
    "tzero/v1/payment/provider.proto|Payment Provider|332"
    "tzero/v1/payment_intent/beneficiary.proto|Payment Intent Beneficiary|333"
    "tzero/v1/payment_intent/network.proto|Payment Intent Network|334"
    "tzero/v1/payment_intent/pay_in_provider.proto|Payment Intent Pay-In Provider|335"
    "ivms101/v1/ivms/ivms101.proto|Travel Rule Data|340"
    "ivms101/v1/ivms/enum.proto|Travel Rule Enums|341"
)

# Derive ALL_PROTOS from PAGES (single source of truth)
ALL_PROTOS=()
for page in "${PAGES[@]}"; do
    IFS='|' read -r proto _ _ <<< "$page"
    ALL_PROTOS+=("$proto")
done

# Build FILEREF sed script: maps anchor(file.Name) -> ../slug/
FILEREF_SED_SCRIPT=$(mktemp)
for proto in "${ALL_PROTOS[@]}"; do
    file_anchor=$(anchor_filter "$proto")
    slug=$(proto_to_slug "$proto")
    echo "s|%%FILEREF:${file_anchor}%%|../${slug}/|g" >> "$FILEREF_SED_SCRIPT"
done
# Also resolve scalar marker
echo "s|%%SCALAR%%|../scalar/|g" >> "$FILEREF_SED_SCRIPT"

gen_page() {
    local active_file="$1"
    local title="$2"
    local weight="$3"
    local slug
    slug=$(proto_to_slug "$active_file")
    local out_file="${slug}.md"
    local out_path="$PROJECT_DIR/content/docs/${OUT_DIR}/${out_file}"

    echo "Generating ${out_file} from ${active_file}..."

    # Pre-process template: inject active file name
    local tmp_template
    tmp_template=$(mktemp)
    sed "s|%%ACTIVE_FILE%%|${active_file}|g" "$TEMPLATE" > "$tmp_template"

    # Run protoc-gen-doc with ALL protos for full type resolution
    protoc \
        --doc_out="$PROJECT_DIR/content/docs/${OUT_DIR}" \
        --doc_opt="$tmp_template,${out_file}" \
        --proto_path="$PROTO_DIR" \
        "${ALL_PROTOS[@]}"

    rm -f "$tmp_template"

    # Post-process: replace %%WEIGHT%% and %%TITLE%%
    local escaped_title
    escaped_title=$(escape_sed "$title")
    sed -i.bak \
        -e "s/%%WEIGHT%%/${weight}/g" \
        -e "s/%%TITLE%%/${escaped_title}/g" \
        "$out_path" && rm -f "${out_path}.bak"

    # Post-process: resolve %%FILEREF:xxx%% and %%SCALAR%% markers
    sed -i.bak -f "$FILEREF_SED_SCRIPT" "$out_path" && rm -f "${out_path}.bak"

}

# Generate all pages
for page in "${PAGES[@]}"; do
    IFS='|' read -r proto title weight <<< "$page"
    gen_page "$proto" "$title" "$weight"
done

rm -f "$FILEREF_SED_SCRIPT"

echo "Done. Generated ${#PAGES[@]} pages."
