# This file is included by DuckDB's build system. It specifies which extension to load

# Extension from this repo
duckdb_extension_load(quack
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}
    LOAD_TESTS
    LINKED_LIBS "../../vcpkg_installed/wasm32-emscripten/lib/libcrypto.a;../../vcpkg_installed/wasm32-emscripten/lib/libssl.a"
)

# Any extra extensions that should be built
# e.g.: duckdb_extension_load(json)
