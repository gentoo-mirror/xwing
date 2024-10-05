# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="The package of IBM's typeface"
HOMEPAGE="https://github.com/IBM/plex"
SRC_URI="
	https://github.com/IBM/plex/releases/download/@ibm/plex-sans@${PV}/${PN}-sans.zip -> ${PN}-sans-${PV}.zip
	https://github.com/IBM/plex/releases/download/@ibm/plex-sans-condensed@${PV}/${PN}-sans-condensed.zip -> ${PN}-sans-condensed-${PV}.zip
	https://github.com/IBM/plex/releases/download/@ibm/plex-serif@${PV}/${PN}-serif.zip -> ${PN}-serif-${PV}.zip
	https://github.com/IBM/plex/releases/download/@ibm/plex-mono@${PV}/${PN}-mono.zip -> ${PN}-mono-${PV}.zip
	https://github.com/IBM/plex/releases/download/@ibm/plex-math@${PV}/${PN}-math.zip -> ${PN}-math-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="app-arch/unzip"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_prepare() {
	default
	mv ${PN}-sans/fonts/complete/ttf/*.ttf . || die
	mv ${PN}-sans-condensed/fonts/complete/ttf/*.ttf . || die
	mv ${PN}-serif/fonts/complete/ttf/*.ttf . || die
	mv ${PN}-mono/fonts/complete/ttf/*.ttf . || die
	mv ${PN}-math/fonts/complete/ttf/*.ttf . || die
}
