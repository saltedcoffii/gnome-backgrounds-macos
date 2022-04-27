# GNOME Backgrounds MacOS

This repository contains build scripts and datafiles to handle using some of the MacOS backgrounds as GNOME backgrounds.

For more information about GNOME Backgrounds, see the upstream repository at https://gitlab.gnome.org/GNOME/gnome-backgrounds

## Building

Dependencies: `meson`, `ninja` (or `samurai` linked to `ninja`), `curl`, and `bash`

Building from the source is easy! Due to copyright limitations, MacOS wallpapers are not contained in this repository and are downloaded from a third party source during build.
A script is provided to perform this download. 
```
./download-backgrounds.sh
meson setup build
ninja -C build
DESTDIR='/' ninja -C build install
```
Be sure to elevate privileges to UID 0 if need be.

## License

CC-BY-SA-3.0.
