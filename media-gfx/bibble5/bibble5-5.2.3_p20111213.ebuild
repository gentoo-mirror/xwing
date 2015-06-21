# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib versionator

DESCRIPTION="Professional photo workflow and RAW conversion software"
HOMEPAGE="http://www.bibblelabs.com"
RESTRICT="mirror strip"
VERSION="${PV%%_p*}"
RELEASEDATE="${PV/*_p/}"
SRC_URI="https://gentoo.xwing.info/distfiles/${PN}-${VERSION}_i386.deb"

LICENSE="bibblepro"
SLOT="5"
KEYWORDS="-* ~x86 ~amd64"
IUSE="brenda"

DEPEND="sys-apps/debianutils"
RDEPEND="virtual/libc
	dev-libs/expat
	dev-libs/glib:2
	x86? (
		sys-libs/zlib
		media-libs/libpng:1.2
		media-libs/tiff:3
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libXxf86vm
	)
	amd64? (
		media-libs/libpng:1.2[abi_x86_32]
		media-libs/tiff:3[abi_x86_32]
		sys-libs/zlib[abi_x86_32]
		media-libs/fontconfig[abi_x86_32]
		media-libs/freetype[abi_x86_32]
		x11-libs/libICE[abi_x86_32]
		x11-libs/libSM[abi_x86_32]
		x11-libs/libX11[abi_x86_32]
		x11-libs/libXau[abi_x86_32]
		x11-libs/libxcb[abi_x86_32]
		x11-libs/libXdamage[abi_x86_32]
		x11-libs/libXdmcp[abi_x86_32]
		x11-libs/libXext[abi_x86_32]
		x11-libs/libXfixes[abi_x86_32]
		x11-libs/libXrender[abi_x86_32]
		x11-libs/libXxf86vm[abi_x86_32]
		media-libs/mesa[abi_x86_32]
	)"

PDEPEND="brenda? ( media-plugins/bibble5-plugins-brenda )"

# Skip some QA checks we cannot fix
QA_EXECSTACK="opt/${PN}/bin/bibble5
	opt/${PN}/lib/libkodakcms.so"
QA_TEXTRELS="opt/bibble5/lib/libkodakcms.so
	opt/${PN}/supportfiles/plugins/BBlackAndWhite.bplugin/lib/BBlackAndWhite.so
	opt/${PN}/supportfiles/plugins/Andrea.bplugin/lib/Andrea.so"
QA_FLAGS_IGNORED="opt/${PN}/supportfiles/libs/NoiseNinja/libnoiseninja\.so.*
	opt/${PN}/supportfiles/plugins/Andrea\.bplugin/lib/Andrea\.so"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

pkg_setup() {
	has_multilib_profile && ABI="x86"
}

src_install() {
	dodir /opt/bibble5

	# bibble binary
	dodir /opt/bibble5/bin
	exeinto /opt/bibble5/bin
	doexe opt/bibble5/bin/bibble5
	exeinto /usr/bin
	doexe usr/bin/bibble5

	# bibble data files
	insinto /opt/bibble5
	doins -r opt/bibble5/supportfiles

	# no libmng available in tree
	rm -f opt/bibble5/lib/plugins/imageformats/libqmng.so
	# bibble libs
	# We use cp -pPR to preserve files (libs) permissions without listing all files
	cp -pPR opt/bibble5/lib "${D}/opt/bibble5/" || die "failed to copy"

	# bibble icon
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins usr/share/pixmaps/bibble5pro.png

	# .desktop file
	insinto /usr/share/applications
	doins usr/share/applications/bibblelabs-bibble5.desktop
}
