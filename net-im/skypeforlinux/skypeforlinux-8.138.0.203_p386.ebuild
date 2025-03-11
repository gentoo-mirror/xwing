# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Skype extracted from snap package without using snap crap."
HOMEPAGE="https://snapcraft.io/skype"
# fetch snap dl url from:
# curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/skype
#         "url": "https://api.snapcraft.io/api/v1/snaps/download/QRDEfjn4WJYnm0FzDKwqqRZZI77awQEV_333.snap"
#      },
#      "revision": 333, => patch level (_p)
#      "version": "8.114.0.214" => version
SRC_URI="https://api.snapcraft.io/api/v1/snaps/download/QRDEfjn4WJYnm0FzDKwqqRZZI77awQEV_${PV/#*_p/}.snap -> ${P}.snap"

S="${WORKDIR}/squashfs-root/usr/share/"

LICENSE="Skype-TOS MIT MIT-with-advertising BSD-1 BSD-2 BSD Apache-2.0 Boost-1.0 ISC CC-BY-SA-3.0 CC0-1.0 openssl ZLIB APSL-2 icu Artistic-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="opt/${PN}/chrome-sandbox
	opt/${PN}/chrome_crashpad_handler
	opt/${PN}/libEGL.so
	opt/${PN}/libffmpeg.so
	opt/${PN}/libGLESv2.so
	opt/${PN}/libvk_swiftshader.so
	opt/${PN}/libvulkan.so.1
	opt/${PN}/${PN}
	opt/${PN}/resources/app.asar.unpacked/modules/electron_utility.node
	opt/${PN}/resources/app.asar.unpacked/modules/keytar.node
	opt/${PN}/resources/app.asar.unpacked/modules/sharing-indicator.node
	opt/${PN}/resources/app.asar.unpacked/modules/slimcore.node"

BDEPEND="sys-fs/squashfs-tools[lzo]"
DEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/libayatana-appindicator
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/freetype:2
	media-gfx/graphite2
	net-print/cups
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/pango
"

src_unpack() {
	unsquashfs "${DISTDIR}"/${P}.snap
}

src_install() {
	insinto /opt
	doins -r ${PN}
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
	fperms u+s /opt/${PN}/chrome-sandbox

	# hack into ayatana-appindicator symlink
	dosym "../../usr/$(get_libdir)/libayatana-appindicator3.so" "opt/${PN}/libappindicator3.so" || die

	# install wrapper reading /etc/chromium/* for CHROME_FLAGS
	exeinto /opt/${PN}
	doexe "${FILESDIR}/${PN}.sh"

	dosym ../../opt/${PN}/${PN}.sh /usr/bin/${PN}

	newicon -s scalable "${FILESDIR}/${PN}.svg" ${PN}.svg
	make_desktop_entry "${EPREFIX}"/opt/${PN}/${PN}.sh "Skype" \
		${PN} "Network;Chat;InstantMessaging;" \
		"MimeType=x-scheme-handler/skype;"
}
