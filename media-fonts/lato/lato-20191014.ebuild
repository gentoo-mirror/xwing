# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

MY_PN="lato-source"
COMMIT="1e13f7349782968838d5ca763bb9157ee1a83926"
DESCRIPTION="Lato is a sanserif type face family"
HOMEPAGE="http://www.latofonts.com/lato-free-fonts/"
SRC_URI="https://github.com/latofonts/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"

DEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_PN}-${COMMIT}"
FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/static/TTF"
DOCS="README.md"
