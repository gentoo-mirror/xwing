# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit font unpacker

DESCRIPTION="Ubuntu Font Family"
HOMEPAGE="https://design.ubuntu.com/font
	https://github.com/canonical/Ubuntu-fonts
	https://github.com/canonical/UbuntuMono-fonts"

SRC_URI="https://gentoo.xwing.info/distfiles/${P}.tar.zst"

LICENSE="UbuntuFontLicense-1.0"
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
