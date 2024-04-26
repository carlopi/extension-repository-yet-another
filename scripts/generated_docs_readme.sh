#!/usr/bin/env bash

mkdir -p docs

duckdb -markdown -c "SELECT file AS 'version/platform/' FROM glob ('v*/*/');" > docs/targets.md

for extension in "$@"
do
    things="extensions functions settings"
    rm -f pre.db
    rm -f post.db
    for thing in $things; do
        duckdb -unsigned pre.db -c "SET extension_directory = './temp'; CREATE OR REPLACE TABLE $thing AS FROM duckdb_$thing();"
        rm -rf temp
        duckdb -unsigned post.db -c "SET extension_directory = './temp'; FORCE INSTALL $extension FROM './'; LOAD $extension; CREATE OR REPLACE TABLE $thing AS FROM duckdb_$thing();"
        rm -rf temp
    done

    mkdir -p docs/$extension

    duckdb post.db -markdown -c "ATTACH 'pre.db'; SELECT function_name, function_type, description, comment, return_type, parameters, parameter_types FROM (FROM ( SELECT * EXCLUDE (database_name, database_oid, function_oid) FROM functions ORDER BY function_name) EXCEPT (SELECT * EXCLUDE (database_name, database_oid, function_oid) FROM pre.functions ORDER BY function_name)) ORDER BY function_name;" > docs/$extension/functions.md

    duckdb post.db -markdown -c "ATTACH 'pre.db'; FROM ( SELECT * EXCLUDE (value) FROM settings ORDER BY name) EXCEPT (SELECT * EXCLUDE (value) FROM pre.settings ORDER BY name) ORDER BY name;" > docs/$extension/settings.md

    duckdb post.db -markdown -c "ATTACH 'pre.db'; FROM ( SELECT * EXCLUDE (install_path, loaded, installed) FROM extensions ORDER BY extension_name) EXCEPT (SELECT * EXCLUDE (install_path, loaded, installed) FROM pre.extensions ORDER BY extension_name) ORDER BY extension_name;" > docs/$extension/extension.md

    rm -f pre.db
    rm -f post.db

    if [ -s "docs/$extension/extension.md" ]; then
       echo "## $extension"
       echo ""
       cat docs/$extension/extension.md
       echo ""

       if [ -s "docs/$extension/functions.md" ]; then
          echo "### Added functions"
          echo ""
          cat docs/$extension/functions.md
          echo ""
       fi
       if [ -s "docs/$extension/settings.md" ]; then
          echo "### Added settings"
          echo ""
          cat docs/$extension/settings.md
          echo ""
       fi
       echo ""
    fi
done

echo ""
echo "## Version / platform combinations"
echo ""
cat docs/targets.md
echo ""
