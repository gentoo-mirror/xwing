# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

HASH="16fee38988bb0f4a0865b6e8c3b332df2d6d8f14"

DESCRIPTION="MPRIS integration for mpv"
HOMEPAGE="https://github.com/hoyon/mpv-mpris"
SRC_URI="https://github.com/hoyon/mpv-mpris/archive/${HASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${HASH}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	media-video/ffmpeg:=
	media-video/mpv[lua]
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	tc-export CC
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install-system
}
