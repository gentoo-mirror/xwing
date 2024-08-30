# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Gtk/Qt front-end to tesseract-ocr"
HOMEPAGE="https://github.com/manisandro/gImageReader"
SRC_URI="https://github.com/manisandro/gImageReader/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="scanner qt6 gtk"

REQUIRED_USE="^^ ( qt6 gtk )"

DEPEND="
	app-text/djvu
	app-text/enchant:2
	app-text/podofo
	app-text/tesseract
	dev-util/intltool
	dev-libs/libxml2
	dev-libs/libzip
	virtual/jpeg
	gtk? (
		app-text/poppler
		dev-cpp/cairomm:0
		dev-cpp/gtkmm
		dev-cpp/gtksourceviewmm
		dev-cpp/libxmlpp:2.6
		dev-cpp/pangomm:1.4
		dev-libs/json-glib
		dev-python/pygobject
	)
	qt6? (
		app-text/poppler[qt6]
		dev-libs/quazip[qt6]
		dev-qt/qtbase:6[concurrent,cups,dbus,network,widgets,xml]
		dev-qt/qtspell
	)
	scanner? ( media-gfx/sane-backends )
"
# missing dep for gtk
#		dev-cpp/gtkspellmm
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DINTERFACE_TYPE=$(usex qt6 qt6 $(usex gtk))
	)

	cmake_src_configure
}
