# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

SANSV="3.006R"
SERIFV="3.000R"
CODEV="2.030R-ro/1.050R-it"

DESCRIPTION="Adobe's open source typeface family designed for UI environments"
HOMEPAGE="https://adobe-fonts.github.io/source-sans-pro/
	https://adobe-fonts.github.io/source-serif-pro/
	https://adobe-fonts.github.io/source-code-pro/"
SRC_URI="https://github.com/adobe-fonts/source-sans-pro/releases/download/${SANSV}/source-sans-pro-${SANSV}.zip
	https://github.com/adobe-fonts/source-serif-pro/releases/download/${SERIFV}/source-serif-pro-${SERIFV}.zip
	https://github.com/adobe-fonts/source-code-pro/archive/${CODEV}.tar.gz -> source-code-pro-${PV}.tar.gz
	https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf
	https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-macos"
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
	mv source-*/VAR/*.ttf . || die
}
