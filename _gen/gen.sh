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

# Pages to generate: "proto_file|title|weight|subdir"
# subdir is optional: it puts the page in a sub-section of OUT_DIR
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
    "tzero/v1/manage/kyc_sharing/applicant_requester.proto|Requester|344|kyc-sharing"
    "tzero/v1/manage/kyc_sharing/applicant_provider.proto|Provider|345|kyc-sharing"
    "tzero/v1/manage/kyc_sharing/file.proto|Files|346|kyc-sharing"
    "tzero/v1/manage/kyc_sharing/form.proto|Form|347|kyc-sharing"
    "tzero/v1/manage/kyc_sharing/common.proto|Common|348|kyc-sharing"
)

# Derive ALL_PROTOS from PAGES (single source of truth)
ALL_PROTOS=()
for page in "${PAGES[@]}"; do
    IFS='|' read -r proto _ _ _ <<< "$page"
    ALL_PROTOS+=("$proto")
done

# Print the FILEREF sed script for a page in sub-section $1 ("" for OUT_DIR itself):
# maps anchor(file.Name) -> relative URL of the page for that file, e.g. ../slug/ or ../../slug/
build_fileref_sed() {
    local from_dir="$1"
    local up="../"
    local parts part page proto dir
    if [[ -n "$from_dir" ]]; then
        IFS='/' read -ra parts <<< "$from_dir"
        for part in "${parts[@]}"; do
            up+="../"
        done
    fi
    for page in "${PAGES[@]}"; do
        IFS='|' read -r proto _ _ dir <<< "$page"
        echo "s|%%FILEREF:$(anchor_filter "$proto")%%|${up}${dir:+${dir}/}$(proto_to_slug "$proto")/|g"
    done
    # Also resolve scalar marker
    echo "s|%%SCALAR%%|${up}scalar/|g"
}

gen_page() {
    local active_file="$1"
    local title="$2"
    local weight="$3"
    local subdir="$4"
    local slug
    slug=$(proto_to_slug "$active_file")
    local out_file="${slug}.md"
    local out_dir="$PROJECT_DIR/content/docs/${OUT_DIR}${subdir:+/${subdir}}"
    local out_path="${out_dir}/${out_file}"

    echo "Generating ${subdir:+${subdir}/}${out_file} from ${active_file}..."
    mkdir -p "$out_dir"

    # Pre-process template: inject active file name
    local tmp_template
    tmp_template=$(mktemp)
    sed "s|%%ACTIVE_FILE%%|${active_file}|g" "$TEMPLATE" > "$tmp_template"

    # Run protoc-gen-doc with ALL protos for full type resolution
    protoc \
        --doc_out="$out_dir" \
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
    local fileref_sed_script
    fileref_sed_script=$(mktemp)
    build_fileref_sed "$subdir" > "$fileref_sed_script"
    sed -i.bak -f "$fileref_sed_script" "$out_path" && rm -f "${out_path}.bak"
    rm -f "$fileref_sed_script"

}

# Generate all pages
for page in "${PAGES[@]}"; do
    IFS='|' read -r proto title weight subdir <<< "$page"
    gen_page "$proto" "$title" "$weight" "$subdir"
done

echo "Done. Generated ${#PAGES[@]} pages."
