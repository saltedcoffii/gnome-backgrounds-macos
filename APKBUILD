# Contributor: Cassandra Watergate <cassandrawatergate@outlook.com>
# Maintainer: Cassandra Watergate <cassandrawatergate@outlook.com>

pkgname=gnome-backgrounds-macos
pkgver=$(grep "  version: " meson.build | cut -d \' -f 2 || exit 1)
pkgrel=0
pkgdesc="Background images for the GNOME desktop from MacOS"
url="https://github.com/saltedcoffii/gnome-backgrounds-macos"
arch="noarch"
license="GPL-3.0-or-later AND CC-BY-SA-3.0"
options="!check"
makedepends="meson>=0.50.0 gettext-dev curl bash"
source="$pkgname-$pkgver.tar.gz::https://github.com/saltedcoffii/$pkgname/archive/$pkgver.tar.gz"

build() {
	$srcdir/$pkgname-$pkgver/download-backgrounds.sh
	abuild-meson output .
	meson compile ${JOBS:+-j ${JOBS}} -C output
}

package() {
	DESTDIR="$pkgdir" meson install --no-rebuild -C output
}

sha512sums="
6715d91b2446912b396df91ee7e35d01c520019b4eb2ef1380a977a54f0ea941e5d6db3351cd299349f00acd0902b26c8545255c19a294ff1355a3b648771288  gnome-backgrounds-macos-42.0.tar.gz
"
