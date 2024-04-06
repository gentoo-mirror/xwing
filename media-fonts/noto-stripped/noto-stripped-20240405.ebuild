# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font unpacker

DESCRIPTION="Google's Noto font, only basic variants (Sans, Serif, Mono)"
HOMEPAGE="https://notofonts.github.io/ https://github.com/notofonts/notofonts.github.io"

SRC_URI="https://gentoo.xwing.info/distfiles/${P}.tar.zst"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Needed for zstd compression
BDEPEND="$(unpacker_src_uri_depends)"
RDEPEND=""
DEPEND=""

RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}"
FONT_SUFFIX="ttf"

src_unpack() {
	unpacker "${P}.tar.zst"
}
