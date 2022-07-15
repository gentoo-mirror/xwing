# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

MY_PN="EBGaramond12"
COMMIT="e608414f52e532b68e2182f96b4ce9db35335593"
DESCRIPTION="Claude Garamont's humanist typeface from the mid-16th century"
HOMEPAGE="https://github.com/octaviopardo/EBGaramond12"
SRC_URI="https://github.com/octaviopardo/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${COMMIT}"
FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/${FONT_SUFFIX}"
DOCS="README.md AUTHORS.txt CONTRIBUTORS.txt"
