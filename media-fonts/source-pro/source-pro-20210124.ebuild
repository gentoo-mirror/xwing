# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

SANSV="3.028R"
SERIFV="3.001R"
CODEV="2.038R-ro/1.058R-it"

DESCRIPTION="Adobe's open source typeface family designed for UI environments"
HOMEPAGE="https://adobe-fonts.github.io/source-sans-pro/
	https://adobe-fonts.github.io/source-serif-pro/
	https://adobe-fonts.github.io/source-code-pro/"
SRC_URI="https://github.com/adobe-fonts/source-sans-pro/releases/download/${SANSV}/source-sans-${SANSV/\./v}.zip
	https://github.com/adobe-fonts/source-serif-pro/releases/download/${SERIFV}/source-serif-pro-${SERIFV}.zip
	https://github.com/adobe-fonts/source-code-pro/releases/download/${CODEV}/1.018R-VAR/TTF-source-code-pro-${CODEV/\//-}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos"
IUSE="cjk"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/fontconfig
	cjk? ( media-fonts/source-han-sans )"

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}"/63-${PN}.conf )
RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	for DISTFILE in ${A}; do
		if [ ${DISTFILE: -4} == ".${FONT_SUFFIX}" ]; then
			cp -a "${DISTDIR}/${DISTFILE}" "${FONT_S}/${DISTFILE}" || die
		fi
	done
}

src_prepare() {
	default
	mv source-*/TTF/*.ttf . || die
	mv TTF/*.ttf . || die
}
