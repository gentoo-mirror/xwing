# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Unofficial Microsoft Teams client for Linux. Binary precompiled version."
HOMEPAGE="https://github.com/IsmaelMartinez/teams-for-linux"
SRC_URI="https://github.com/IsmaelMartinez/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="opt/${PN}/chrome-sandbox
	opt/${PN}/chrome_crashpad_handler
	opt/${PN}/libEGL.so
	opt/${PN}/libffmpeg.so
	opt/${PN}/libGLESv2.so
	opt/${PN}/libvk_swiftshader.so
	opt/${PN}/libvulkan.so.1
	opt/${PN}/${PN}"

DEPEND="
	app-accessibility/at-spi2-core:2
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

src_install() {
	insinto /opt/${PN}
	doins -r .
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
	fperms u+s /opt/${PN}/chrome-sandbox

	# install wrapper reading /etc/chromium/* for CHROME_FLAGS
	exeinto /opt/${PN}
	doexe "${FILESDIR}/${PN}.sh"

	dosym ../../opt/${PN}/${PN}.sh /usr/bin/${PN}

	newicon -s scalable "${FILESDIR}/${PN}.svg" ${PN}.svg
	make_desktop_entry "${EPREFIX}"/opt/${PN}/${PN}.sh "Teams for Linux" \
		${PN} "Network;Chat;InstantMessaging;" \
		"MimeType=x-scheme-handler/msteams;"
}
