# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A strong, neutral, principles-driven, open source typeface for text or display"
HOMEPAGE="https://public-sans.digital.gov/"
SRC_URI="https://github.com/uswds/public-sans/releases/download/v${PV}/${PN}-v${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/fonts/ttf"
FONT_S="${S}"
FONT_SUFFIX="ttf"
