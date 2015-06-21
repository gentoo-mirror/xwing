# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: Guillaume Castagnino <casta@xwing.info>
# Purpose: Manage dependancy and install for AfterShotPro plugins
#

inherit eutils multilib
EXPORT_FUNCTIONS pkg_nofetch pkg_setup src_install

LICENSE="AfterShotPro"
SLOT="0"

DEPEND="app-arch/unzip"
RDEPEND=">=media-gfx/AfterShotPro-1"

RESTRICT="strip mirror"

S="${WORKDIR}"

QA_TEXTRELS=""

# @ECLASS-VARIABLE: MY_DOWNLOAD_URI
# @DESCRIPTION:
# This internal variable contains the fetch URI for the fetch-restricted plugins

# Private vars

# @ECLASS-VARIABLE: PLUGIN_DIR
# @DESCRIPTION:
# This internal variable contains the path for all AfterShotPro plugins files
# Warning : must NOT contain the initial /
PLUGIN_DIR=opt/AfterShotPro/supportfiles/plugins/

# Exported functions

# @FUNCTION: asp-plugins_pkg_nofetch
# @DESCRIPTION:
# This function is the default pkg_nofetch
asp-plugins_pkg_nofetch() {
	debug-print-function ${FUNCNAME} $*

	elog "Please first purchase and download ${PN} plugin from the site:"
	elog "${MY_DOWNLOAD_URI}"
	elog "then put the ${A} file in ${DISTDIR}"
}

# @FUNCTION: asp-plugins_pkg_setup
# @DESCRIPTION:
# Default pkg_setup function
asp-plugins_pkg_setup() {
	debug-print-function ${FUNCNAME} $*

	has_multilib_profile && ABI="x86"
}

# @FUNCTION: asp-plugins_src_install
# @DESCRIPTION:
# This function install the plugins refering to the files set into PLUGINS var
asp-plugins_src_install() {
	debug-print-function ${FUNCNAME} $*

	cd "${WORKDIR}"
	insinto "${ROOT}/${PLUGIN_DIR}${MY_PN}.afplugin"
	doins "${MY_PN}.afplugin/Info.afpxml"
	doins -r "${MY_PN}.afplugin/ui"
	[ -d "${MY_PN}.afplugin/lang" ] &&  doins -r "${MY_PN}.afplugin/lang"
	insopts -m0755
	doins -r "${MY_PN}.afplugin/lib"
}

# Other functions

# @FUNCTION: asp-plugins-fetch
# @USAGE: < Download URI >
# @DESCRIPTION:
# This function enable fetch restriction for asp plugin
asp-plugins-fetch() {
	debug-print-function ${FUNCNAME} $*

	MY_DOWNLOAD_URI="$1"
	RESTRICT="${RESTRICT} fetch"
}

# @FUNCTION: asp-plugins-qa
# @DESCRIPTION:
# This function add the good QA_TEXTRELS to avoid warnings that can't be fixed
# due to non-PIC code (binary plugins, no source here)
# PLUGINS var must be set before calling this function
asp-plugins-qa() {
	debug-print-function ${FUNCNAME} $*
	
	QA_TEXTRELS="${QA_TEXTRELS} \
	${PLUGIN_DIR}${MY_PN}.afplugin/lib/*.so
	${PLUGIN_DIR}${MY_PN}.afplugin/lib/*.so.*"
}

# @FUNCTION: asp-plugins-block
# @USAGE: < USE flag >
# @DESCRIPTION:
# This function check if asp is built with the specified USE flag and die if
# not with a standard notice
asp-plugins-block() {
	debug-print-function ${FUNCNAME} $*

	BLOCK_USE="$1"

	if ! has_version media-gfx/AfterShotPro[${BLOCK_USE}]; then
		eerror "Please add '${BLOCK_USE}' to your USE flags, and re-emerge AfterShotPro."
		die "AfterShotPro needs ${BLOCK_USE} USE flag to avoid collisions"
	fi
}

