# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

MY_PN="EBGaramond12"
COMMIT="8e8d2aff04abb39fceca0b1e8da1f444e466fb3b"
DESCRIPTION="Claude Garamont's humanist typeface from the mid-16th century"
HOMEPAGE="https://github.com/octaviopardo/EBGaramond12"
SRC_URI="https://github.com/octaviopardo/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${COMMIT}"
FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/${FONT_SUFFIX}"
DOCS="README.md AUTHORS.txt CONTRIBUTORS.txt"
