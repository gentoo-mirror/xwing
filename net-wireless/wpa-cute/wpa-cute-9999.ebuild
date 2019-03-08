# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 desktop qmake-utils

DESCRIPTION="A graphical wpa_supplicant front end"
HOMEPAGE="https://github.com/loh-tar/wpa-cute"
EGIT_REPO_URI="https://github.com/loh-tar/wpa-cute.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	pushd "src"
	eqmake5
	popd
}

src_compile() {
	emake -C "src"
}

src_install() {
	into /usr
	dobin "src/wpa-cute"
	newicon "src/icons/wpa_gui.svg" wpa-cute.svg
	domenu "src/wpa-cute.desktop"
	doman "doc/wpa-cute.8"
}
