# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit font

DESCRIPTION="Ubuntu Font Family"
HOMEPAGE="https://design.ubuntu.com/font
	https://github.com/canonical/Ubuntu-fonts
	https://github.com/canonical/UbuntuMono-fonts"

SRC_URI="https://gentoo.xwing.info/distfiles/${P}.tar.xz"

LICENSE="UbuntuFontLicense-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}"
FONT_SUFFIX="ttf"
