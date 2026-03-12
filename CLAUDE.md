# CLAUDE.md

## Project Overview

Hugo-based documentation site for t-0 network. API reference docs are auto-generated from protobuf definitions.

## Doc Generation (`_gen/`)

- `_gen/gen.sh` generates API reference markdown from proto files in `proto/`
- `_gen/gen-doc-template.tmpl` is the Go template used by `protoc-gen-doc`
- Requires `protoc` (latest) and `protoc-gen-doc` (pinned in `go.mod` via `tool` directive)
- **Important**: `protoc-gen-doc` pre-built release binaries are incompatible with protoc v28+. Always build from source with `go install`
- The `PAGES` array in `gen.sh` is the single source of truth for which proto files to document. `ALL_PROTOS` is derived from it.
- CI workflow (`.github/workflows/generate.yaml`) auto-generates docs on PRs that touch `proto/` or `content/docs/`

### Cross-file type links

Each proto file becomes its own markdown page. The template resolves type references to determine if a link should be:
- **Local** (`#anchor`) — type is defined in the same proto file
- **Cross-file** (`../other_page/#anchor`) — type is defined in another proto file
- **Scalar** (`../scalar/#anchor`) — built-in protobuf scalar types (int32, string, etc.)

The mechanism uses placeholder markers in the template that get resolved by `gen.sh`:
1. Template uses `%%ACTIVE_FILE%%` to filter — only renders types from the current proto file
2. For each type reference, the template scans all files to find where it's defined
3. Cross-file refs emit `%%FILEREF:<file_anchor>%%` markers, scalar refs emit `%%SCALAR%%`
4. `gen.sh` post-processes with sed to replace markers with relative Hugo URLs (`../slug/`)
5. The FILEREF sed script is built from the same `PAGES` array, mapping `anchor(proto_path)` -> `../slug/`

## Commands

- Generate docs: `./_gen/gen.sh`
- Run Hugo dev server: `hugo server`
- Build site: `hugo --gc --minify`
