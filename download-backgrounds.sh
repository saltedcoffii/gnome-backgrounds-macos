#!/bin/bash
set -e

declare -A downloads=(
  ['https://512pixels.net/downloads/macos-wallpapers/11-0-Night.jpg']='bigsur-d.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers/11-0-Day.jpg']='bigsur-l.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers/11-0-Big-Sur-Color-Night.jpg']='bigsur-color-d.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers/11-0-Color-Day.jpg']='bigsur-color-l.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers/10-15-Night.jpg']='catalina-d.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers/10-15-Day.jpg']='catalina-l.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers-6k/10-14-Night-6k.jpg']='mojave-d.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers-6k/10-14-Day-6k.jpg']='mojave-l.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers-6k/12-Dark.jpg']='monterey-d.jpg'
  ['https://512pixels.net/downloads/macos-wallpapers-6k/12-Light.jpg']='monterey-l.jpg'

)

for url in "${!downloads[@]}"; do
  curl -L "${url}" -o $(dirname $0)/backgrounds/"${downloads[${url}]}";
done

