#!/usr/bin/env bash
set -e

_baseurl="https://512pixels.net/downloads/macos-wallpapers"

declare -A downloads=(
  ["$_baseurl/11-0-Night.jpg"]="bigsur-d.jpg"
  ["$_baseurl/11-0-Day.jpg"]="bigsur-l.jpg"
  ["$_baseurl/11-0-Big-Sur-Color-Night.jpg"]="bigsur-color-d.jpg"
  ["$_baseurl/11-0-Color-Day.jpg"]="bigsur-color-l.jpg"
  ["$_baseurl/10-15-Night.jpg"]="catalina-d.jpg"
  ["$_baseurl/10-15-Day.jpg"]="catalina-l.jpg"
  ["$_baseurl-6k/10-14-Day-6k.jpg"]="mojave-l.jpg"
  ["$_baseurl-6k/10-14-Night-6k.jpg"]="mojave-d.jpg"
  ["$_baseurl-6k/12-Dark.jpg"]="monterey-d.jpg"
  ["$_baseurl-6k/12-Light.jpg"]="monterey-l.jpg"
)

for url in "${!downloads[@]}"; do
  curl -L "${url}" -o "$(dirname "$0")"/backgrounds/"${downloads[${url}]}";
done

pushd backgrounds
  sha256sum -c images.sha256
popd
