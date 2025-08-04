# To generate the docs run from the `proto` directory:


## Generate Network Service Documentation
```bash
    docker run --rm \
    -v $(pwd)/../../docs:/out \
    -v $(pwd)/../../proto:/protos \
    pseudomuto/protoc-gen-doc --doc_opt=/out/template/gen-doc-template.tmpl,network.md tzero/v1/payment/network.proto
```

## Generate Provider API Documentation
```bash
    docker run --rm \
    -v $(pwd)/../../docs:/out \
    -v $(pwd)/../../proto:/protos \
    pseudomuto/protoc-gen-doc --doc_opt=/out/template/gen-doc-template.tmpl,provider.md tzero/v1/payment/provider.proto
```

## Generate Common package Documentation
```bash
    docker run --rm \
    -v $(pwd)/../../docs:/out \
    -v $(pwd)/../../proto:/protos \
    pseudomuto/protoc-gen-doc --doc_opt=/out/template/gen-doc-template.tmpl,common.md tzero/v1/common/common.proto tzero/v1/common/payment_method.proto 
```
