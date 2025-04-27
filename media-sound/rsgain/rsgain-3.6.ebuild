# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A simple, but powerful ReplayGain 2.0 tagging utility"
HOMEPAGE="https://github.com/complexlogic/rsgain"
SRC_URI="https://github.com/complexlogic/rsgain/releases/download/v${PV}/${P}-source.tar.xz"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~riscv ~sparc ~x86"

RDEPEND="
	dev-libs/inih
	dev-libs/libfmt
	media-libs/libebur128
	media-libs/libogg
	media-libs/libvorbis
	media-libs/taglib
	media-video/ffmpeg
"

DEPEND="${RDEPEND}"
