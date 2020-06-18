# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="Google Noto Emoji fonts, minimal package"
HOMEPAGE="https://github.com/googlefonts/noto-emoji"

SRC_URI="https://gentoo.xwing.info/distfiles/${P}.tar.xz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}"
FONT_SUFFIX="ttf"
