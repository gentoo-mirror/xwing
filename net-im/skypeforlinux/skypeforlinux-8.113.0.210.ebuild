# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg multilib-build

DESCRIPTION="Skype extracted from snap package without using snap crap."
HOMEPAGE="https://snapcraft.io/skype"
# fetch snap dl url from:
# curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/skype
SRC_URI="https://api.snapcraft.io/api/v1/snaps/download/QRDEfjn4WJYnm0FzDKwqqRZZI77awQEV_330.snap -> ${P}.snap"

S="${WORKDIR}/squashfs-root/usr/share/${PN}/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"

BDEPEND="sys-fs/squashfs-tools[lzo]"
DEPEND="
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-gfx/graphite2[${MULTILIB_USEDEP}]
	net-print/cups[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]
"

src_unpack() {
	unsquashfs "${DISTDIR}"/${P}.snap
}

src_install() {
	dodir /opt/${PN}
	cp -a . "${ED}"/opt/${PN} || die

	# install wrapper reading /etc/chromium/* for CHROME_FLAGS
	exeinto /opt/${PN}
	doexe "${FILESDIR}/${PN}.sh"

	# remove chrome-sandbox binary, users should use kernel namespaces
	# https://bugs.gentoo.org/692692#c18
	rm "${ED}"/opt/${PN}/chrome-sandbox || die

	dosym ../../opt/${PN}/${PN}.sh /usr/bin/${PN}

	newicon -s scalable "${FILESDIR}/${PN}.svg" ${PN}.svg
	make_desktop_entry "${EPREFIX}"/opt/${PN}/${PN}.sh "Skype" \
		${PN} "Network;Chat;InstantMessaging;" \
		"MimeType=x-scheme-handler/skype;"
}
