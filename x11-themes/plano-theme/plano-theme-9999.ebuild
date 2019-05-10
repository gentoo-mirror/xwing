# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="plano theme for GNOME, Xfce and more."
HOMEPAGE="https://github.com/lassekongo83/plano-theme"
EGIT_REPO_URI="https://github.com/lassekongo83/plano-theme.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-shell openbox xfce"

DEPEND="
	>=x11-libs/gtk+-2:2
	>=x11-libs/gtk+-3.20:3
	>=x11-libs/gdk-pixbuf-2:2
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_install() {
	rm -rf LICENSE README.md plano.png .gitignore .gitattributes
	rm -r xfwm4/{*.sh,assets.txt,assets.svg}
	rm -r gnome-shell/{gnome-shell-sass,*.scss,*.sh}
	rm -r gtk-2.0/{*.sh,assets.txt,assets.svg,README}
	rm -r gtk-3.0/{*.scss,*.sh,assets.txt,assets.svg,*.md}

	insinto /usr/share/themes/Plano
	doins -r gtk-2.0/
	doins -r gtk-3.0/
	use gnome-shell && doins -r gnome-shell/
	use xfce && doins -r xfwm4/
	use openbox && doins -r openbox-3/
}
