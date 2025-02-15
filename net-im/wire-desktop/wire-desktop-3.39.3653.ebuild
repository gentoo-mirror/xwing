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
IUSE="system-ffmpeg system-mesa"

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
	system-ffmpeg? ( >=media-video/ffmpeg-6[chromium] )
	system-mesa? ( media-libs/mesa[vulkan] )
"
S="${WORKDIR}"
QA_PREBUILT="opt/${OPTNAME}/*"

src_install() {
	dodir /opt/${OPTNAME}
	cp -a opt/${OPTNAME} "${ED}/opt/" || die

	if use system-ffmpeg; then
		rm "${ED}/opt/${OPTNAME}/libffmpeg.so" || die
		dosym "../../usr/$(get_libdir)/chromium/libffmpeg.so" "opt/${OPTNAME}/libffmpeg.so" || die
		elog "Using system ffmpeg. This is experimental and may lead to crashes."
	fi

	if use system-mesa; then
		rm "${ED}/opt/${OPTNAME}/libEGL.so" || die
		rm "${ED}/opt/${OPTNAME}/libGLESv2.so" || die
		rm "${ED}/opt/${OPTNAME}/libvulkan.so.1" || die
		rm "${ED}/opt/${OPTNAME}/libvk_swiftshader.so" || die
		rm "${ED}/opt/${OPTNAME}/vk_swiftshader_icd.json" || die
		elog "Using system mesa. This is experimental and may lead to crashes."
	fi

	# install wrapper reading /etc/chromium/* for CHROME_FLAGS
	exeinto /opt/${OPTNAME}
	doexe "${FILESDIR}/${PN}.sh"

	# remove chrome-sandbox binary, users should use kernel namespaces
	# https://bugs.gentoo.org/692692#c18
	rm "${ED}/opt/${OPTNAME}/chrome-sandbox" || die

	dosym ../../opt/${OPTNAME}/${PN}.sh /usr/bin/${PN}

	sed -si -e "s/^Exec=.*$/Exec=\/usr\/bin\/${PN} %U/" usr/share/applications/${PN}.desktop
	domenu usr/share/applications/${PN}.desktop

	doicon -s 32 usr/share/icons/hicolor/32x32/apps/${PN}.png
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/${PN}.png
}
