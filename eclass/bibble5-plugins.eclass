# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: Guillaume Castagnino <casta@xwing.info>
# Purpose: Manage dependancy and install for bibble plugins
#

inherit eutils multilib
EXPORT_FUNCTIONS pkg_nofetch pkg_setup src_install

LICENSE="bibblepro"
SLOT="0"

DEPEND="app-arch/unzip"
RDEPEND=">=media-gfx/bibble5-5.1"

RESTRICT="strip"

QA_TEXTRELS=""

S="${WORKDIR}"

# @ECLASS-VARIABLE: MY_DOWNLOAD_URI
# @DESCRIPTION:
# This internal variable contains the fetch URI for the fetch-restricted plugins

# Private vars

# @ECLASS-VARIABLE: PLUGIN_DIR
# @DESCRIPTION:
# This internal variable contains the path for all bibble plugins files
# Warning : must NOT contain the initial /
PLUGIN_DIR=opt/bibble5/supportfiles/plugins/

# Exported functions

# @FUNCTION: bibble5-plugins_pkg_nofetch
# @DESCRIPTION:
# This function is the default pkg_nofetch
bibble5-plugins_pkg_nofetch() {
	debug-print-function ${FUNCNAME} $*

	elog "Please first purchase and download ${PN} plugin from the site:"
	elog "${MY_DOWNLOAD_URI}"
	elog "then put the ${A} file in ${DISTDIR}"
}

# @FUNCTION: bibble5-plugins_pkg_setup
# @DESCRIPTION:
# Default pkg_setup function
bibble5-plugins_pkg_setup() {
	debug-print-function ${FUNCNAME} $*

	has_multilib_profile && ABI="x86"
}

# @FUNCTION: bibble5-plugins_src_install
# @DESCRIPTION:
# This function install the plugins refering to the files set into PLUGINS var
bibble5-plugins_src_install() {
	debug-print-function ${FUNCNAME} $*

	cd "${WORKDIR}"
	insinto "${ROOT}/${PLUGIN_DIR}${MY_PN}.bplugin"
	doins "${MY_PN}.bplugin/Info.bpxml"
	doins -r "${MY_PN}.bplugin/ui"
	[ -d "${MY_PN}.bplugin/lang" ] &&  doins -r "${MY_PN}.bplugin/lang"
	insopts -m0755
	doins -r "${MY_PN}.bplugin/lib"
}

# Other functions

# @FUNCTION: bibble5-plugins-fetch
# @USAGE: < Download URI >
# @DESCRIPTION:
# This function enable fetch restriction for bibble plugin
bibble5-plugins-fetch() {
	debug-print-function ${FUNCNAME} $*

	MY_DOWNLOAD_URI="$1"
	RESTRICT="${RESTRICT} fetch"
}

# @FUNCTION: bibble5-plugins-qa
# @DESCRIPTION:
# This function add the good QA_TEXTRELS to avoid warnings that can't be fixed
# due to non-PIC code (binary plugins, no source here)
# PLUGINS var must be set before calling this function
bibble5-plugins-qa() {
	debug-print-function ${FUNCNAME} $*
	
	QA_TEXTRELS="${QA_TEXTRELS} \
	${PLUGIN_DIR}${MY_PN}.bplugin/lib/*.so"
}

# @FUNCTION: bibble5-plugins-block
# @USAGE: < USE flag >
# @DESCRIPTION:
# This function check if bibble is built with the specified USE flag and die if
# not with a standard notice
bibble5-plugins-block() {
	debug-print-function ${FUNCNAME} $*

	BLOCK_USE="$1"

	if ! has_version media-gfx/bibble5[${BLOCK_USE}]; then
		eerror "Please add '${BLOCK_USE}' to your USE flags, and re-emerge bibble5."
		die "bibblepro-bin needs ${BLOCK_USE} USE flag to avoid collisions"
	fi
}

