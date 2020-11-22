# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit systemd

DESCRIPTION="spampd is a program to scan messages for Unsolicited Commercial E-mail content"
HOMEPAGE="http://www.worlddesign.com/index.cfm/rd/mta/spampd.htm"
SRC_URI="https://github.com/mpaperno/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Net-Server
	mail-filter/spamassassin"
DEPEND="${RDEPEND}"
BDEPEND=""

src_install() {
	dosbin spampd.pl
	dodoc changelog.txt misc/spampd-rh-rc-script.sh
	dohtml spampd.html
	newinitd "${FILESDIR}"/init spampd
	newconfd "${FILESDIR}"/conf spampd

	systemd_dounit "${FILESDIR}/${PN}.service"
}
