# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg-utils

DESCRIPTION="Media Player Classic Qute Theater"
HOMEPAGE="https://github.com/mpc-qt/mpc-qt"
SRC_URI="https://github.com/mpc-qt/mpc-qt"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/mpc-qt/mpc-qt.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/mpc-qt/mpc-qt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="media-video/mpv[libmpv]
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	default
	# fix doc path
	sed -e '/^\s*docs.path/s:'${PN}':'${PF}':' -i mpc-qt.pro || die
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
