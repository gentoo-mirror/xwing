# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="A Arial Narrow replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://github.com/liberationfonts/liberation-sans-narrow"
SRC_URI="https://github.com/liberationfonts/${PN}/files/2579431/liberation-narrow-fonts-ttf-${PV}.tar.gz"

LICENSE="GPL-2-with-font-exception"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~x86 ~x64-cygwin ~amd64-linux ~x86-linux ~x64-solaris"
IUSE=""

S="${WORKDIR}/liberation-narrow-fonts-ttf-${PV}"
FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/60-liberation-narrow.conf" )
