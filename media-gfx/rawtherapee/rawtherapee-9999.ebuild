# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils toolchain-funcs git-r3 flag-o-matic

DESCRIPTION="A powerful cross-platform raw image processing program"
HOMEPAGE="http://www.rawtherapee.com/"
EGIT_REPO_URI="https://github.com/Beep6581/RawTherapee.git"
EGIT_BRANCH="dev"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="bzip2 openmp"

RDEPEND="bzip2? ( app-arch/bzip2 )
	x11-libs/gtk+:3
	dev-libs/expat
	dev-libs/libsigc++:2
	media-libs/libcanberra[gtk3]
	media-libs/tiff:0
	media-libs/libpng:0
	media-libs/libiptcdata
	media-libs/lcms:2
	sci-libs/fftw:3.0
	sys-libs/zlib
	virtual/jpeg:0"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	dev-cpp/gtkmm:3.0"

pkg_pretend() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_configure() {
	filter-flags -ffast-math
	local mycmakeargs=(
		-DOPTION_OMP=$(usex openmp)
		-DBZIP=$(usex bzip2)
		-DDOCDIR=/usr/share/doc/${PF}
		-DCREDITSDIR=/usr/share/${PN}
		-DLICENCEDIR=/usr/share/${PN}
		-DCACHE_NAME_SUFFIX=""
	)

	# lots of speed improvement, rawtherapee devs advice to use it.
	replace-flags -O? -O3

	cmake-utils_src_configure
}
