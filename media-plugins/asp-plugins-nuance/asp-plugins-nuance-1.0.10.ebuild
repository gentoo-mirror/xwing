# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit asp-plugins

MY_PN="Nuance"

DESCRIPTION="Nuance - Colour Grading"
HOMEPAGE="http://nexi.com/nuance"
SRC_URI="http://nexi.com/asp/package/${MY_PN}-${PV}.afzplug -> ${MY_PN}-${PV}.zip"

KEYWORDS="~x86 ~amd64"
IUSE=""

asp-plugins-qa

#asp-plugins-fetch "http://nexi.com/software/paid/"
