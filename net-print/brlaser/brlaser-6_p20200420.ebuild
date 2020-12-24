# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

COMMIT="9d7ddda8383bfc4d205b5e1b49de2b8bcd9137f1"

DESCRIPTION="Brother laser printer driver"
HOMEPAGE="https://github.com/pdewacht/brlaser"
SRC_URI="https://github.com/pdewacht/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-print/cups"
RDEPEND="
	${DEPEND}
	app-text/ghostscript-gpl"

S="${WORKDIR}/${PN}-${COMMIT}"
