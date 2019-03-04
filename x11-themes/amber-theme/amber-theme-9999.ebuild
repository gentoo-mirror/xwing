# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Amber theme for GNOME, Xfce and more."
HOMEPAGE="https://github.com/lassekongo83/amber-theme"
EGIT_REPO_URI="https://github.com/lassekongo83/amber-theme.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xfce gnome-shell"

DEPEND="
	>=x11-libs/gtk+-2:2
	>=x11-libs/gtk+-3.20:3
	>=x11-libs/gdk-pixbuf-2:2
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_install() {
	rm -r src/xfwm4/{*.build,*.sh,assets.txt,assets.svg}
	rm -r src/gnome-shell/{gnome-shell-sass,*.build,*.scss,*.sh}
	rm -r src/gtk-2.0/{*.build,*.sh,assets.txt,assets.svg,README}
	rm -r src/gtk-3.0/{*.build,*.scss,*.sh,assets.txt,assets.svg,*.md}

	sed -si -e "s/@ThemeName@/$THEME_NAME/g" src/index.theme.in

	insinto /usr/share/themes/Amber
	doins -r src/gtk-2.0/
	doins -r src/gtk-3.0/
	use gnome-shell && doins -r src/gnome-shell/
	use xfce && doins -r src/xfwm4/
}
