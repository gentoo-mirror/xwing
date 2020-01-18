# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson

DESCRIPTION="Amber theme for GNOME, Xfce and more."
HOMEPAGE="https://github.com/lassekongo83/amber-theme"
EGIT_REPO_URI="https://github.com/lassekongo83/amber-theme.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="custom gnome-shell xfce"

DEPEND="
	custom? ( dev-lang/sassc )
	>=x11-libs/gtk+-2:2
	>=x11-libs/gtk+-3.20:3
	>=x11-libs/gdk-pixbuf-2:2
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	if use custom; then
		# replace orange by blue
		sed -si -e "s/fb6f55/75A4D9/" src/gtk-3.0/_colors.scss || die
		# regen CSS with changes
		cd src/gtk-3.0 && sh parse-sass.sh || die
	fi

	use gnome-shell || sed -i -e "/gnome-shell/d" src/meson.build
	use xfce || sed -i -e "/xfwm4/d" src/meson.build
}

