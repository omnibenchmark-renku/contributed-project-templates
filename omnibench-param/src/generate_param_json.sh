#!/usr/bin/env bash


#####################
## DO NOT MODIFIY ###
#####################

set -eo pipefail

source src/config.sh

### -------------------------------------------- ###
## ------------- Define inputs ------------------ ##
### -------------------------------------------- ###

out_file="${OUT_PATH}/${OUT_NAME}"

### -------------------------------------------- ###
## ---------- Create parameter JSON ------------- ##
### -------------------------------------------- ###

out_json='{}'
for key in "${!PARAM_AR[@]}"; do
    out_json=$(jq -n --argjson v "$(printf '"%s"' "${PARAM_AR[$key]}")" --argjson out "$out_json" --arg key "$key" '$out + {($key): [$v]}')
done

echo -e "${out_json}\n" > $out_file



