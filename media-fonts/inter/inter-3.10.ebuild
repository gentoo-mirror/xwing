# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="The Inter font family"
HOMEPAGE="https://rsms.me/inter/"
#SRC_URI="https://github.com/rsms/${PN}/releases/download/v${PV}/Inter-${PV}.zip"c
# for now use a custom build as calt feature is broken and thus annoying
SRC_URI="https://gentoo.xwing.info/distfiles/${P}-no-calt.tar.xz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"

DEPEND="app-arch/unzip"

S=${WORKDIR}
FONT_S=${S}
FONT_SUFFIX="ttf"
