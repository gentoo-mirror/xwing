# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Session Desktop - Onion routing based messenger"
HOMEPAGE="https://getsession.org/"
SRC_URI="https://github.com/session-foundation/${PN}/releases/download/v${PV}/${PN}-linux-amd64-${PV}.deb"
S="${WORKDIR}"
OPTNAME="Session"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="opt/${OPTNAME}/chrome-sandbox
	opt/${OPTNAME}/chrome_crashpad_handler
	opt/${OPTNAME}/libEGL.so
	opt/${OPTNAME}/libffmpeg.so
	opt/${OPTNAME}/libGLESv2.so
	opt/${OPTNAME}/libvk_swiftshader.so
	opt/${OPTNAME}/libvulkan.so.1
	opt/${OPTNAME}/${PN}"

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
	insinto /
	doins -r opt
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
	fperms u+s /opt/${OPTNAME}/chrome-sandbox

	# install wrapper reading /etc/chromium/* for CHROME_FLAGS
	exeinto /opt/${OPTNAME}
	doexe "${FILESDIR}/${PN}.sh"

	dosym ../../opt/${PN}/${PN}.sh /usr/bin/${PN}

	sed -si -e "s/^Exec=.*$/Exec=\/usr\/bin\/${PN} %U/" usr/share/applications/${PN}.desktop
	domenu usr/share/applications/${PN}.desktop

	local res
	for res in 16 32 48 64 128 256 512 1024; do
		doicon -s ${res} usr/share/icons/hicolor/${res}x${res}/apps/${PN}.png
	done
}
