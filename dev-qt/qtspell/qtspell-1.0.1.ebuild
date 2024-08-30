# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Spell checking for Qt text widgets "
HOMEPAGE="https://github.com/manisandro/qtspell"
SRC_URI="https://github.com/manisandro/${PN}/archive/${PV}.tar.gz -> $P.tar.gz"

LICENSE=""GPL-3
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-text/enchant:2
	dev-qt/qtbase[widgets]
	dev-qt/qttools[linguist]
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DQT_VER=6
	)

	cmake_src_configure
}
