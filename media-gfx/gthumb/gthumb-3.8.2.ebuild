# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"

inherit gnome2 meson

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="https://wiki.gnome.org/Apps/gthumb"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="cdr colord exif gnome-keyring gstreamer http jpeg lcms raw slideshow svg tiff test webp"

RDEPEND="
	>=dev-libs/glib-2.38.0:2[dbus]
	>=x11-libs/gtk+-3.16.0:3
	exif? ( >=media-gfx/exiv2-0.21:= )
	slideshow? (
		>=media-libs/clutter-1.12.0:1.0
		>=media-libs/clutter-gtk-1:1.0 )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-plugins/gst-plugins-gtk:1.0 )
	raw? ( >=media-libs/libraw-0.14:= )
	gnome-keyring? ( >=app-crypt/libsecret-0.11 )
	cdr? ( >=app-cdr/brasero-3.2 )
	svg? ( >=gnome-base/librsvg-2.34:2 )
	webp? ( >=media-libs/libwebp-0.2.0 )
	lcms? ( >=media-libs/lcms-2.6:2 )
	colord? ( >=x11-misc/colord-1.3
		>=media-libs/lcms-2.6:2 )
	http? (
		>=net-libs/webkit-gtk-1.10.0:4
		>=net-libs/libsoup-2.42.0:2.4
		>=dev-libs/json-glib-0.15.0
	)

	media-libs/libpng:0=
	sys-libs/zlib
	>=gnome-base/gsettings-desktop-schemas-0.1.4
	jpeg? ( virtual/jpeg:0= )
	tiff? ( media-libs/tiff:= )
"
DEPEND="${RDEPEND}
	dev-util/glib-utils
	>=dev-util/intltool-0.50.1
	dev-util/itstool
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )
"
# eautoreconf needs:
#	gnome-base/gnome-common

src_configure() {
	# Upstream says in configure help that libchamplain support
	# crashes frequently
	local emesonargs=(
		-Dlibchamplain=false
		$(meson_use cdr libbrasero)
		$(meson_use colord)
		$(meson_use exif exiv2)
		$(meson_use gnome-keyring libsecret)
		$(meson_use gstreamer)
		$(meson_use raw libraw)
		$(meson_use slideshow clutter)
		$(meson_use svg librsvg)
		$(meson_use tiff libtiff)
		$(meson_use webp libwebp)
		$(meson_use http webservices)
	)
	# colord pulls in lcms2 anyway, so enable lcms with USE="colord -lcms"; some of upstream HAVE_COLORD code depends on HAVE_LCMS2
	if use lcms || use colord; then
		emesonargs+=( -Dlcms2=true )
	else
		emesonargs+=( -Dlcms2=false )
	fi
	meson_src_configure
}
