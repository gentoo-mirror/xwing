# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

MY_PN="NunitoSans"
COMMIT="5fc7eb2a1c4a4644a0b8240a76ab5c397a0cd663"
DESCRIPTION="Nunito Sans is a well balanced Sans Serif"
HOMEPAGE="https://github.com/Fonthausen/NunitoSans"
SRC_URI="https://github.com/Fonthausen/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${COMMIT}"
FONT_SUFFIX="ttf"
FONT_S="${S}/fonts"
DOCS="README.md AUTHORS.txt CONTRIBUTORS.txt"
