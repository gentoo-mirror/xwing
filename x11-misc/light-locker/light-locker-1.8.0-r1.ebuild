# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils

DESCRIPTION="A simple locker using lightdm"
HOMEPAGE="https://github.com/the-cavalry/light-locker"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+consolekit +dpms +elogind gtk3 +screensaver -systemd +upower"

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.25.6:2
	>=sys-apps/dbus-0.30
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/pango
	x11-libs/libXxf86vm
	consolekit? ( sys-auth/consolekit )
	dpms? ( x11-libs/libXext )
	!gtk3? ( >=x11-libs/gtk+-2.24:2 )
	gtk3? ( x11-libs/gtk+:3 )
	screensaver? ( x11-libs/libXScrnSaver )
	systemd? ( sys-apps/systemd )
	elogind? ( sys-auth/elogind )
	upower? ( sys-power/upower )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	dev-util/intltool
	sys-devel/gettext"
RDEPEND="${RDEPEND}
	x11-misc/lightdm"

REQUIRED_USE="?? ( elogind systemd )"

DOCS=( AUTHORS HACKING NEWS README )

src_prepare() {
	epatch "${FILESDIR}/${PN}-${PV}-elogind.patch"
	# remove xdt-autogen specific macro (just like upstream do) as we need to autoreconf
	sed -si -e "/XDT_I18N/d" configure.ac
	eapply_user
	eautoreconf
}

src_configure() {
	econf \
		$(use_with consolekit console-kit) \
		$(use_with dpms dpms-ext) \
		$(use_with !gtk3 gtk2) \
		$(use_with screensaver x) \
		$(use_with screensaver mit-ext) \
		$(use_with systemd) \
		$(use_with elogind) \
		$(use_with upower)
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
