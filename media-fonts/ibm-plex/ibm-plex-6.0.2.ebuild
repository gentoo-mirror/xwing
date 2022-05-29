# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="The package of IBM's typeface"
HOMEPAGE="https://github.com/IBM/plex"
SRC_URI="https://github.com/IBM/plex/releases/download/v${PV}/TrueType.zip -> ${PN}-TrueType-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/TrueType"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_prepare() {
	default
	mv IBM-Plex-Sans-Condensed/*.ttf . || die
	mv IBM-Plex-Sans/*.ttf . || die
	mv IBM-Plex-Mono/*.ttf . || die
	mv IBM-Plex-Serif/*.ttf . || die
}
