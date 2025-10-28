#!/bin/bash

escape_sed_replacement() {
    printf '%s' "$1" | sed 's/[&@\\]/\\&/g'
}

gen() {
    local out_dir="$1"
    local out_file="$2"
    local title=$(escape_sed_replacement "$3")
    local weight=$4
    local out="$1/$2"
    shift
    shift
    shift
    shift


    docker run --rm \
        -v $(pwd)/content/docs/${out_dir}:/out \
        -v $(pwd)/_gen/gen-doc-template.tmpl:/gen-doc-template.tmpl \
        -v $(pwd)/proto:/protos \
        pseudomuto/protoc-gen-doc --doc_opt=/gen-doc-template.tmpl,${out_file} $@

    sed -i.bak \
      -e "s/%%WEIGHT%%/${weight}/g" \
      -e "s/%%TITLE%%/${title}/g" \
      "content/docs/${out}" && rm "content/docs/${out}.bak"
}

gen "integration-guidance/api-reference" "common.md" "Common" 338 tzero/v1/common/common.proto tzero/v1/common/payment_method.proto

gen "integration-guidance/api-reference" "payment-network.md" "Payment Network" 331 tzero/v1/payment/network.proto
gen "integration-guidance/api-reference" "payment-provider.md" "Payment Provider" 332 tzero/v1/payment/provider.proto

gen "integration-guidance/api-reference" "payment-intent-provider.md" "Payment Intent Provider" 333 tzero/v1/payment_intent/provider/provider.proto
gen "integration-guidance/api-reference" "payment-intent-recipient.md" "Payment Intent Recipient" 334 tzero/v1/payment_intent/recipient/recipient.proto

gen "integration-guidance/api-reference" "travel-rule.md" "Travel Rule Data" 335 ivms101/v1/ivms/ivms101.proto ivms101/v1/ivms/enum.proto
#gen "integration-guidance/api-reference" "travel-rule-enums.md" "Travel Rule Data Constants" 336 ivms101/v1/ivms/enum.proto
