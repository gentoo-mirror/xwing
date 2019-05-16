# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font git-r3

DESCRIPTION="Claude Garamont's humanist typeface from the mid-16th century"
HOMEPAGE="https://github.com/octaviopardo/EBGaramond12"
EGIT_REPO_URI="https://github.com/octaviopardo/EBGaramond12.git"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

FONT_SUFFIX="otf"
FONT_S="${S}/fonts/${FONT_SUFFIX}"
DOCS="README.md AUTHORS.txt CONTRIBUTORS.txt"
