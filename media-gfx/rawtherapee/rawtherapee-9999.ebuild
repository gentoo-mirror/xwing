# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic toolchain-funcs xdg-utils git-r3

DESCRIPTION="A powerful cross-platform raw image processing program"
HOMEPAGE="https://www.rawtherapee.com/"
EGIT_REPO_URI="https://github.com/Beep6581/RawTherapee.git"
EGIT_BRANCH="dev"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="clang jpegxl lto openmp system-libraw tcmalloc"

RDEPEND="
	dev-cpp/atkmm:0
	dev-cpp/cairomm:0
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-cpp/pangomm:1.4
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libsigc++:2
	gnome-base/librsvg:2
	media-gfx/exiv2:=
	media-libs/lcms:2
	media-libs/lensfun
	|| (
		media-libs/libcanberra-gtk3
		media-libs/libcanberra[gtk3(-)]
	)
	media-libs/libiptcdata
	media-libs/libjpeg-turbo:=
	media-libs/libpng:0=
	media-libs/tiff:=
	sci-libs/fftw:3.0=
	sys-libs/zlib
	x11-libs/gtk+:3
	jpegxl? ( media-libs/libjxl:= )
	system-libraw? ( media-libs/libraw )
	tcmalloc? ( dev-util/google-perftools )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	clang? (
		|| (
			(	sys-devel/clang:19
				sys-devel/llvm:19
				=sys-devel/lld-19*	)
			(	sys-devel/clang:18
				sys-devel/llvm:18
				=sys-devel/lld-18*	)
			(	sys-devel/clang:17
				sys-devel/llvm:17
				=sys-devel/lld-17*	)
			(	sys-devel/clang:16
				sys-devel/llvm:16
				=sys-devel/lld-16*	)
			(	sys-devel/clang:15
				sys-devel/llvm:15
				=sys-devel/lld-15*	)
		)
	)
"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_configure() {
	# upstream tested that "fast-math" give wrong results, so filter it
	# https://bugs.gentoo.org/show_bug.cgi?id=606896#c2
	filter-flags -ffast-math
	# -Ofast enable "fast-math" both in gcc and clang
	replace-flags -Ofast -O3
	# In case we add an ebuild for klt we can (i)use that one,
	# see http://cecas.clemson.edu/~stb/klt/

	if use clang ; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang ..."
		AR=llvm-ar
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		NM=llvm-nm
		RANLIB=llvm-ranlib
		LDFLAGS+=" -fuse-ld=lld"
	else
		# Force gcc
		einfo "Enforcing the use of gcc due to USE=-clang ..."
		AR=gcc-ar
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		NM=gcc-nm
		RANLIB=gcc-ranlib
	fi

	local mycmakeargs=(
		-DOPTION_OMP=$(usex openmp)
		-DDOCDIR=/usr/share/doc/${PF}
		-DCREDITSDIR=/usr/share/${PN}
		-DLICENCEDIR=/usr/share/${PN}
		-DCACHE_NAME_SUFFIX=""
		-DWITH_SYSTEM_KLT="off"
		-DWITH_LTO=$(usex lto)
		-DWITH_SYSTEM_LIBRAW=$(usex system-libraw)
		-DENABLE_TCMALLOC=$(usex tcmalloc)
		-DWITH_JXL=$(usex jpegxl)
	)

	# lots of speed improvement, rawtherapee devs advice to use it.
	replace-flags -O? -O3

	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
