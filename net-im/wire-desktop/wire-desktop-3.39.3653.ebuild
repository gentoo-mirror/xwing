# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker

OPTNAME="Wire"
DESCRIPTION="Wire for desktop"
HOMEPAGE="https://wire.com"
SRC_URI="https://github.com/wireapp/${PN}/releases/download/linux/${PV}/${OPTNAME}-${PV}_amd64.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"

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
S="${WORKDIR}"
QA_PREBUILT="opt/${OPTNAME}/chrome-sandbox
	opt/${OPTNAME}/chrome_crashpad_handler
	opt/${OPTNAME}/libEGL.so
	opt/${OPTNAME}/libffmpeg.so
	opt/${OPTNAME}/libGLESv2.so
	opt/${OPTNAME}/libvk_swiftshader.so
	opt/${OPTNAME}/libvulkan.so.1
	opt/${OPTNAME}/${PN}"

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

	dosym ../../opt/${OPTNAME}/${PN}.sh /usr/bin/${PN}

	sed -si -e "s/^Exec=.*$/Exec=\/usr\/bin\/${PN} %U/" usr/share/applications/${PN}.desktop
	domenu usr/share/applications/${PN}.desktop

	doicon -s 32 usr/share/icons/hicolor/32x32/apps/${PN}.png
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/${PN}.png
}
