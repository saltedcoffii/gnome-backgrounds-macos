# GNOME Backgrounds MacOS

This repository contains build scripts and XML files to handle using some of the MacOS backgrounds as GNOME backgrounds.

For more information about GNOME Backgrounds, see the upstream repository at https://gitlab.gnome.org/GNOME/gnome-backgrounds

## Installing on various Linux distributions

Note that for all of these distros, the `gnome-shell` must be version 42.0 or above.
```
$ gnome-shell --version
```

### Arch Linux, Manjaro Linux and derivatives

[gnome-backgrounds-macos](https://aur.archlinux.org/packages/gnome-backgrounds-macos/) is available in the AUR. The VCS version is [also available](https://aur.archlinux.org/packages/gnome-backgrounds-macos-git/).

Install using your favorite [AUR helper](https://wiki.archlinux.org/title/AUR_helpers), e.g.,

```
$ yay -S gnome-backgrounds-macos
```

You may also install manually using [makepkg](https://wiki.archlinux.org/title/Makepkg) to build from the AUR directly (not recommended).

```
# pacman -S --needed git base-devel
$ git clone https://aur.archlinux.org/gnome-backgrounds-macos.git --depth 1
$ cd gnome-backgrounds-macos
$ makepkg -si
```

Manjaro users: You can install using [pamac (aka Add/Remove Software)](https://wiki.manjaro.org/index.php?title=Pamac)

```
$ pamac build gnome-backgrounds-macos
```

### Alpine Linux and derivatives

Installing gnome-backgrounds-macos on [Alpine Linux](https://alpinelinux.org/) may be a bit trickier than other distros. I cannot provide an APK, because the APK would contain backgrounds under copyright. I may choose to provide an APK that downloads the images as a post-install hook, however that is not currently the case. Pull requests welcome!

To build an installable apk, first [setup your Alpine system to build APKs](https://wiki.alpinelinux.org/wiki/Include:Setup_your_system_and_account_for_building_packages)

Then, download and extract the [latest release](https://github.com/saltedcoffii/gnome-backgrounds-macos/releases/) of the project and extract it.

```
$ curl -LO <latest-release-tarball>.tar.gz
$ tar xf <latest-release-tarball>.tar.gz
$ cd gnome-backgrounds-macos-<version>
```

or clone the source directly for the most recent (and possibly less stable) source.

```
$ git clone https://github.com/saltedcoffii/gnome-backgrounds-macos.git --depth 1
$ cd gnome-backgrounds-macos
```

Then, build and install the APK!

```
$ abuild -r
# apk add ${HOME}/packages/$(whoami)/$(uname -r)/gnome-backgrounds-macos*.apk
```

You can delete the source and build directories now if you aren't planning on doing any more APK building, you don't need them.

### Other Linux distributions

This package should theoretically work on any Linux distribution with GNOME installed. If you'd like support added for your distribution, please open a [new issue](https://github.com/saltedcoffii/gnome-backgrounds-macos/issues/), after ensuring that nobody else has already requested that distro. If you are a maintainer for a distribution, please don't hesitate to add this package! Alternatively, build and install from the source directly (see below).

## Usage

After installation, open up the GNOME settings application (aka `gnome-control-center`) and navigate to the Appearance tab. The backgrounds should appear, along with the default GNOME backgrounds, assuming they are installed.

## Building from source

Dependencies:
  - `meson` (v0.50.0 or above)
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

Install without a package manager after building from source (not recommended).

```
# DESTDIR='/' ninja -C build install
```

I hope to soon provide support for installing on a per-user basis.

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
