#!/usr/bin/env bash
script_name="$0"
usage() {
    echo "USAGE: $script_name urls.sh"
}

[[ $# -eq 1 ]] || { usage; exit 1; }

source "$1"

[[ -v download_links ]] || {
    echo "download_links variable not set in $1"; 
    exit 2; 
}

for url in "${download_links[@]}"; do
    echo "Downloading $url"
    filename="$(echo "$url" | sed -E 's/.*\/([^?]+?)\?.*/\1/g')"
    echo "$filename"
    wget -c "$url" -O "$filename"
done
