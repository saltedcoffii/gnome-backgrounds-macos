# GNOME Backgrounds MacOS

This repository contains build scripts and XML files to handle using some of the MacOS backgrounds as GNOME backgrounds.

For more information about GNOME Backgrounds, see the upstream repository at https://gitlab.gnome.org/GNOME/gnome-backgrounds

## Installing on various Linux distributions

### Arch Linux, Manjaro Linux and derivatives

[gnome-backgrounds-macos](https://aur.archlinux.org/packages/gnome-backgrounds-macos/) is available in the AUR. The VCS version is [also available](https://aur.archlinux.org/packages/gnome-backgrounds-macos-git/).

Install using your favorite [AUR helper](https://wiki.archlinux.org/title/AUR_helpers), e.g.,

```
$ yay -S gnome-backgrounds-macos
```

You may also install manually using [makepkg](https://wiki.archlinux.org/title/Makepkg) to build from the AUR directly (not recommended).

```
# pacman -S --needed base-devel
$ git clone https://aur.archlinux.org/gnome-backgrounds-macos.git --depth 1
$ cd gnome-backgrounds-macos
$ makepkg -si
```

Manjaro users: You can install using [pamac (aka Add/Remove Software)](https://wiki.manjaro.org/index.php?title=Pamac)

```
$ pamac build gnome-backgrounds-macos
```

### Other Linux distributions

This package should theoretically work on any Linux distribution with GNOME installed. If you'd like support added for your distribution, please open a [new issue](https://github.com/saltedcoffii/gnome-backgrounds-macos/issues/), after ensuring that nobody else has already requested that distro. If you are a maintainer for a distribution, please don't hesitate to add this package!

## Building from source

Dependencies:
  - `meson` (v 0.50.0 or above)
  - `ninja` (or `samurai` linked to `ninja`)
  - `curl`
  - `bash`

Building from the source is easy! Due to copyright limitations, MacOS wallpapers are not contained in this repository and are downloaded from a third party source during build.
A script is provided to perform this download.
```
$ ./download-backgrounds.sh
$ meson setup build
$ ninja -C build
```

Install without a package manager after building from source (not recommended)
```
# DESTDIR='/' ninja -C build install
```

## Additional Resources and Information

### Further MacOS Skinning

To further MacOS-ize your GNOME desktop, consider adding a MacOS-like GTK them and icon theme.

https://github.com/vinceliuice/WhiteSur-gtk-theme/

https://github.com/vinceliuice/WhiteSur-icon-theme/

https://github.com/vinceliuice/WhiteSur-cursors/

### Versioning Scheme

GNOME Backgrounds MacOS uses [semantic versioning](https://semver.org/) with a couple tweaks. The first two numbers, major and minor versions, match the corresponding version of [GNOME Backgrounds](https://gitlab.gnome.org/GNOME/gnome-backgrounds). The patch version, if any, mark adjustments to this repository specifically, independent of GNOME Backgrounds upstream.

## License and Legal

See [COPYING.md](https://github.com/saltedcoffii/blob/master/COPYING.md) for details.
