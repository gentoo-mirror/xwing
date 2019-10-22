# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Lato is a sanserif type face family"
HOMEPAGE="http://www.latofonts.com/lato-free-fonts/"
SRC_URI="http://www.latofonts.com/download/Lato2OFL.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"

DEPEND="app-arch/unzip"

S=${WORKDIR}
FONT_S="${S}/Lato2OFL"

FONT_SUFFIX="ttf"
