# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A modern flat theme that supports Gnome, Unity, XFCE and Openbox."
HOMEPAGE="https://numixproject.org"
LICENSE="GPL-3+"
SLOT="0"
IUSE="+custom-colors"

BASE_URI="https://github.com/numixproject/${PN}"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${BASE_URI}.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

DEPEND="
	x11-themes/gtk-engines-murrine
	dev-ruby/sass:*
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	if use custom-colors ; then
		sed -si -e 's/f0544c/397db5/' -e 's/f06860/4778b3/' -e 's/fc6f5d/4787bf/' \
			src/gtk-3.0/scss/_global.scss \
			src/gtk-3.20/scss/_global.scss \
			src/gtk-2.0/gtkrc
	fi
}

src_compile() {
	emake DESTDIR="${D}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
