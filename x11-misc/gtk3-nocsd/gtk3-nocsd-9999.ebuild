# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A hack to disable gtk3 client-side decorations"
HOMEPAGE="https://github.com/PCMan/gtk3-nocsd"

EGIT_REPO_URI="https://github.com/PCMan/gtk3-nocsd.git"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_install() {
	emake prefix="${D}/usr" install

	doenvd "${FILESDIR}"/90gtk3-nocsd
}
