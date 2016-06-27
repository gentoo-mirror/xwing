# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator multilib multilib-minimal

DESCRIPTION="Professional photo workflow and RAW conversion software"
HOMEPAGE="http://www.corel.com/corel/product/index.jsp?pid=prod4670071"
RESTRICT="mirror strip"

ABI32_URL="http://dwnld.aftershotpro.com/updates/v2/${PV}/${PN}2_i386.deb -> ${PN}-${PV}_i386.deb"
ABI64_URL="http://dwnld.aftershotpro.com/updates/v2/${PV}/${PN}2_amd64.deb -> ${PN}-${PV}_amd64.deb"

SRC_URI="
	amd64? ( abi_x86_32? ( ${ABI32_URL} ) !abi_x86_32? ( ${ABI64_URL} ) )
	x86? ( ${ABI32_URL} )
"

LICENSE="AfterShotPro"
SLOT="2"
KEYWORDS="-* ~x86 ~amd64"

REQUIRED_USE="
	|| ( abi_x86_64 abi_x86_32 )
"

NATIVE_DEPS="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libffi
	sys-libs/zlib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	media-libs/tiff:3
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrender
"
DEPEND="sys-apps/debianutils"
RDEPEND="
	amd64? (
		abi_x86_32? (
			dev-libs/expat[abi_x86_32(-)]
			dev-libs/glib:2[abi_x86_32(-)]
			dev-libs/libffi[abi_x86_32(-)]
			sys-libs/zlib[abi_x86_32(-)]
			media-libs/libpng[abi_x86_32(-)]
			media-libs/tiff:3[abi_x86_32(-)]
			media-libs/fontconfig[abi_x86_32(-)]
			media-libs/freetype[abi_x86_32(-)]
			x11-libs/libICE[abi_x86_32(-)]
			x11-libs/libSM[abi_x86_32(-)]
			x11-libs/libX11[abi_x86_32(-)]
			x11-libs/libXau[abi_x86_32(-)]
			x11-libs/libxcb[abi_x86_32(-)]
			x11-libs/libXdmcp[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
			x11-libs/libXrender[abi_x86_32(-)]
		)
		!abi_x86_32? ( ${NATIVE_DEPS} )
	)
	x86? ( ${NATIVE_DEPS} )
"

BASEDIR="opt/AfterShot2"
BASEDIR="!abi_x86_32? ( ${BASEDIR}(64-bit) )"
SUFFIX="!abi_x86_32? ( X64 )"

# Skip some QA checks we cannot fix
QA_DESKTOP_FILE="usr/share/applications/AfterShot2${SUFFIX}.desktop"
QA_EXECDIR="${BASEDIR}/bin/AfterShot"
QA_WX_LOAD="${BASEDIR}/bin/AfterShot"
QA_FLAGS_IGNORED="${BASEDIR}/lib/libOpenCL\.so.*
	${BASEDIR}/lib/libgomp\.so.*
	${BASEDIR}/supportfiles/libs/NoiseNinja/libnoiseninja\.so.*"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_install() {
	dodir "/${BASEDIR}"

	# AfterShot binary
	dodir "/${BASEDIR}/bin"
	exeinto "/${BASEDIR}/bin"
	doexe "${BASEDIR}/bin/AfterShotPro"
	dodir "/${BASEDIR}/bin/Corel AfterShot HDR/"
	exeinto "/${BASEDIR}/bin/Corel AfterShot HDR/"
	doexe "${BASEDIR}/bin/Corel AfterShot HDR/Corel Aftershot HDR"
	exeinto /usr/bin
	doexe usr/bin/AfterShot2${SUFFIX}

	# AfterShot HDR data files
	insinto "/${BASEDIR}/bin/Corel AfterShot HDR"
	doins -r "${BASEDIR}/bin/Corel AfterShot HDR/Brushes"
	doins -r "${BASEDIR}/bin/Corel AfterShot HDR/CameraCurve"
	doins -r "${BASEDIR}/bin/Corel AfterShot HDR/GettingStartedPage"
	doins -r "${BASEDIR}/bin/Corel AfterShot HDR/Presets"
	doins -r "${BASEDIR}/bin/Corel AfterShot HDR/PSPPProvidePreset"

	# AfterShot data files
	insinto "/${BASEDIR}"
	doins -r "${BASEDIR}/supportfiles"

	# AfterShot libs
	# We use cp -pPR to preserve files (libs) permissions without listing all files
	cp -pPR "${BASEDIR}/lib" "${D}/${BASEDIR}/" || die "failed to copy"

	# AfterShot icon
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins usr/share/pixmaps/AfterShot2${SUFFIX}.png

	# .desktop file
	insinto /usr/share/applications
	doins usr/share/applications/AfterShot2${SUFFIX}.desktop
}
