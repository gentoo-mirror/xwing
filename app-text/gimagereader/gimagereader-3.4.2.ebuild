# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="A Gtk/Qt front-end to tesseract-ocr"
HOMEPAGE="https://github.com/manisandro/gImageReader"
SRC_URI="https://github.com/manisandro/gImageReader/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="scanner"

DEPEND="
	app-text/djvu
	app-text/enchant:2
	app-text/podofo
	app-text/poppler[qt6]
	app-text/tesseract
	dev-libs/libxml2
	dev-libs/libzip
	dev-libs/quazip[qt6]
	dev-qt/qtbase:6[concurrent,cups,dbus,network,widgets,xml]
	dev-qt/qtspell
	media-libs/libjpeg-turbo
"
RDEPEND="${DEPEND}
	scanner? ( media-gfx/sane-backends )
"
BDEPEND="${DEPEND}
	dev-util/intltool
"

src_configure() {
	local mycmakeargs=(
		-DINTERFACE_TYPE=qt6
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
