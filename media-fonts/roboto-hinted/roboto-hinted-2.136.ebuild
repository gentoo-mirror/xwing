# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Standard font for Android 4.0 (Ice Cream Sandwich) and later, hinted version"
HOMEPAGE="https://github.com/google/roboto"
SRC_URI="https://github.com/google/roboto/releases/download/v${PV}/${PN}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"

DEPEND="app-arch/unzip"
RDEPEND="!media-fonts/roboto"

S=${WORKDIR}
FONT_S="${S}/${PN}"

FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}"/90-roboto-regular.conf )
