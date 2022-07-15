# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Zuki themes for GNOME, Xfce and more."
HOMEPAGE="https://github.com/lassekongo83/zuki-themes"
EGIT_REPO_URI="https://github.com/lassekongo83/zuki-themes.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xfce"

DEPEND="
	>=x11-themes/gnome-themes-standard-3.6
"
RDEPEND="dev-lang/sassc"

src_prepare() {
	default

	use xfce || sed -i -e "/xfwm4/d" meson.build
}
