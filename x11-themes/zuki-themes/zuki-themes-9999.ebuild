# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Zuki themes for GNOME, Xfce and more."
HOMEPAGE="https://github.com/lassekongo83/zuki-themes"
EGIT_REPO_URI="https://github.com/lassekongo83/zuki-themes.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xfce"

DEPEND="
	>=x11-libs/gtk+-2:2
	>=x11-libs/gtk+-3.24:3
	>=x11-libs/gdk-pixbuf-2:2
	x11-themes/gtk-engines-murrine
	dev-lang/sassc"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	use xfce || sed -i -e "/xfwm4/d" meson.build
}
