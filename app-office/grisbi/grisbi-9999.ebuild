# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 git-2

DESCRIPTION="Grisbi is a personal accounting application for Linux"
HOMEPAGE="http://www.grisbi.org"
SRC_URI=""
IUSE="nls ofx ssl goffice"

EGIT_REPO_URI="git://grisbi.git.sourceforge.net/gitroot/grisbi/grisbi"
EGIT_BOOTSTRAP="autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2.18.0:2
	>=x11-libs/gtk+-2.12.0:2
	x11-misc/xdg-utils
	ssl? ( >=dev-libs/openssl-0.9.7 )
	ofx? ( >=dev-libs/libofx-0.7.0 )
	goffice? ( >=x11-libs/goffice-0.8.0 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	G2CONF+="--with-libxml2
		--without-cunit
		--disable-static
		$(use_with ssl openssl)
		$(use_with ofx)
		$(use_with goffice)
		$(use_enable nls)"
	DOCS="AUTHORS NEWS README"
}
