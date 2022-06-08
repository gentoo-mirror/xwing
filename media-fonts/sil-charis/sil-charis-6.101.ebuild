# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="CharisSIL"
inherit font

DESCRIPTION="Serif typeface for Roman and Cyrillic languages"
HOMEPAGE="https://software.sil.org/charis/"
SRC_URI="https://github.com/silnrsi/font-charis/releases/download/v6.101/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~loong ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x64-macos"
IUSE=""

FONT_SUFFIX="ttf"
