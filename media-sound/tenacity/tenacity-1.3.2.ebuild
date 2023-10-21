# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"

inherit cmake wxwidgets xdg

DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="https://tenacityaudio.org/"

MY_PV="${PV/_p/-}"
MY_PV="${MY_PV/_/-}"
SRC_URI="https://codeberg.org/tenacityteam/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

# GPL-2: Tenacity code
# CC-BY-3.0: Tenacity Documentation
# CC-BY-4.0: Audacity Logo
# Nyquist: BSD-style license for ./lib-src/libnyquist
# BSD: ./lib-src/libnyquist/xlisp
LICENSE="GPL-2 CC-BY-3.0 CC-BY-4.0 Nyquist BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ffmpeg +flac id3tag +ladspa +lv2 mad matroska +midi ogg +vorbis sbsms soundtouch twolame +vst2 vamp"

# vst2 dep on GTK+3[X]: https://github.com/tenacityteam/tenacity/issues/614
RDEPEND="dev-db/sqlite:3
	dev-libs/expat
	dev-libs/glib:2
	media-libs/libsndfile
	media-libs/portaudio
	media-libs/soxr
	media-sound/lame
	sys-libs/zlib:=
	x11-libs/gtk+:3
	x11-libs/wxGTK:${WX_GTK_VER}[X]
	virtual/opengl
	ffmpeg? ( media-video/ffmpeg:= )
	flac? ( media-libs/flac:=[cxx] )
	id3tag? ( media-libs/libid3tag:= )
	lv2? (
		media-libs/lilv
		media-libs/lv2
		media-libs/suil
	)
	mad? ( media-libs/libmad )
	matroska? ( media-libs/libmatroska )
	midi? (
		media-libs/portmidi:=
		media-libs/portsmf:=
	)
	ogg? ( media-libs/libogg )
	sbsms? ( media-libs/libsbsms )
	soundtouch? ( media-libs/libsoundtouch:= )
	twolame? ( media-sound/twolame )
	vorbis? ( media-libs/libvorbis )
	vamp? ( media-libs/vamp-plugin-sdk )
	vst2? ( x11-libs/gtk+:3[X] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	app-text/scdoc
"

DOCS=( LICENSE.txt README.md )

PATCHES=(
	"${FILESDIR}"/${PN}-cursors-header.patch
)

src_configure() {
	setup-wxwidgets

	local mycmakeargs=(
		# Tell the CMake-based build system it's building a release.
		-DAUDACITY_BUILD_LEVEL=2
		-DMIDI=$(usex midi)
		-DID3TAG=$(usex id3tag)
		-DMATROSKA=$(usex matroska)
		-DMP3_DECODING=$(usex mad)
		-DMP2=$(usex twolame)
		-DOGG=$(usex ogg)
		-DVORBIS=$(usex vorbis)
		-DFLAC=$(usex flac)
		-DSBSMS=$(usex sbsms)
		-DSOUNDTOUCH=$(usex soundtouch)
		-DFFMPEG=$(usex ffmpeg)
		-DLADSPA=$(usex ladspa)
		-DLV2=$(usex lv2)
		-DVAMP=$(usex vamp)
		-DVST2=$(usex vst2)
	)

	cmake_src_configure
}
