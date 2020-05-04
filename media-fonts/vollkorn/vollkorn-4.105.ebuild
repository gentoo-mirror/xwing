# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Vollkorn, the free and healthy typeface for bread and butter use"
HOMEPAGE="http://vollkorn-typeface.com/"
SRC_URI="http://vollkorn-typeface.com/download/${PN}-${PV/./-}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

FONT_S="${S}/TTF"
FONT_SUFFIX="ttf"
DOCS="Fontlog.txt"
