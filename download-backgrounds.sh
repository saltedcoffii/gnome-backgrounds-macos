#!/usr/bin/env bash
set -e

abort () {
  echo "${@}" && exit 1
}

# Get the getopts_long function
source "$(dirname "${0}")"/build/getopts_long/lib/getopts_long.bash || \
  abort -e "\e[1;31mCould not find \e[1;33mbuild/getopts_long/lib/getopts_long.bash\e[1;31m. Did you forget to intiate submodules?\e[0m"

# Help output
help () {
  local exit_code=${1:-0}

cat >&2 << help_message

  Usage: ${0##*/} [OPTION]
  Download and verify the backgrounds

  Options:
    -d, --downloader                   request the use of a specific program to download the files
                                        Currently supported: aria2, wget, and curl
    -h, --help                         help (this message)

help_message

  exit "${exit_code}"
}


# Script options and help
while getopts_long ':d:h? downloader: help' OPTKEY; do
  case "${OPTKEY}" in
    'd'|'downloader')
      requested_downloader="${OPTARG}"
      ;;
    'h'|'?'|'help')
      help 0
      ;;
    *)
      help 1
      ;;
  esac
done

# Check which downloader to use
[[ "${requested_downloader}" == 'aria2' ]] && \
  requested_downloader='aria2c'

if [[ -n "${requested_downloader}" ]] && [[ "${requested_downloader}" =~ ^(aria2c|wget|curl)$ ]]; then
  downloader="${requested_downloader}"
elif [[ -z "${requested_downloader}" ]]; then # Autodetect downloader
  for i in 'aria2c' 'wget' 'curl' 'fail'; do
    if [[ -x $(command -v "${i}") ]]; then
      if [[ "${i}" == 'fail' ]]; then
        abort "\e[1;31mCould not find \e[1;31maria2c\e[1;31m, \e[1;31mwget\e[1;31m, or \e[1;31mcurl\e[1;31m in PATH\e[0m"
      fi
      downloader="${i}"
      break
    fi
  done
else # If the regex above doesn't get matched
  abort -e "\e[1;33m${requested_downloader}\e[1;31m is not a supported downloader\e[0m"
fi

do_dl () {
  local url="${1}"
  local filename="${2}"

  case "${downloader}" in
    'aria2'|'aria2c')
      aria2c "${url}" -o "${filename}"
      ;;
    'wget')
      wget "${url}" -O "${filename}"
      ;;
    'curl')
      echo -e "\e[1;32mDownloading \e[1;33m$(basename "${filename}")\e[0m"
      curl -L "${url}" -o "${filename}"
      ;;
  esac
}

# Just some data for the script
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

declare -A checksums=(
  ["7cc1938d70eebdbf3b2fce374a8ff7fdf607f5dc8bce681e58c682ec8f83f540"]="bigsur-d.jpg"
  ["d228004f1a1dd90fa49ef04c7799ad80d98e6b19cc1c7cf28c7d484b86a8759d"]="bigsur-l.jpg"
  ["dcb77341ab0ff62f8c78bb80d38d9a27cc1f32e8fb53189c761b5bc29f79d542"]="bigsur-color-d.jpg"
  ["0280d927dbc32654e7912599a8770d2a0b90fe91db73a7a4c5e2f58dc29edc4d"]="bigsur-color-l.jpg"
  ["ca7911fc9f8747e1bbaef871fb1b871bdb17613fb3ef1fa89a808ac514058d21"]="catalina-d.jpg"
  ["d943a2dd89718c3e98d0f3eccca4a512c3cca72042096d5a20e137e0db851549"]="catalina-l.jpg"
  ["78026ff4bacdb45e77407dfc4b33a31930febb375a50870f31cf6a0e430f8739"]="mojave-l.jpg"
  ["d6116c9b5fb3c8f11b05ecdaf0c0713e2d9ceefd0837175f6ebfc425f3f66f27"]="mojave-d.jpg"
  ["793eeca80015ebd80ae6863b8b691b5ae1d4b90cc32fd64b69b21a751f4a32b1"]="monterey-d.jpg"
  ["99234643ebe6943d727c5a8bf2e36ca8f9fe47cf4fa15700e7e35e8d35b8d710"]="monterey-l.jpg"
)

# Check for existing files
declare -A validated=()

for sha256sum in "${!checksums[@]}"; do
  filename="$(dirname "${0}")"/backgrounds/"${checksums[${sha256sum}]}"
  if [[ -f "${filename}" ]]; then
    real_sha256sum="$(sha256sum "${filename}" | cut -d " " -f 1)"
    if [[ "${real_sha256sum}" == "${sha256sum}" ]]; then
      validated+=(["${checksums[${sha256sum}]}"]=0)
    else
      echo -e "\e[1;33m${checksums[${sha256sum}]}\e[1;31m has an incorrect checksum. Redownloading.\e[0m"
      rm -f "${filename}"
      [[ -e "${filename}.aria2" ]] && rm -f "${filename}.aria2"
    fi
  fi
done

# Download files if they are missing or incorrect
for url in "${!downloads[@]}"; do
  filename="$(dirname "${0}")"/backgrounds/"${downloads[${url}]}"
  if [[ -v validated["${downloads[${url}]}"] ]]; then
    continue
  fi
  do_dl "${url}" "${filename}"
done
