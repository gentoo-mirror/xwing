# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit asp-plugins

MY_PN="Nostalgia"

DESCRIPTION="Nostalgia - Film Simulation"
HOMEPAGE="http://nexi.com/nostalgia"
SRC_URI="http://nexi.com/asp/package/${MY_PN}-${PV}.afzplug -> ${MY_PN}-${PV}.zip"

KEYWORDS="~x86 ~amd64"
IUSE=""

asp-plugins-qa

#asp-plugins-fetch "http://nexi.com/software/paid/"
