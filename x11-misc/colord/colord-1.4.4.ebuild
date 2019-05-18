# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

inherit meson bash-completion-r1 check-reqs gnome2 user systemd udev vala multilib-minimal

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="https://www.freedesktop.org/software/colord/"
SRC_URI="https://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0/2" # subslot = libcolord soname version
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="argyllcms examples extra-print-profiles scanner systemd vala"

COMMON_DEPEND="
	dev-db/sqlite:3=[${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.44.0:2[${MULTILIB_USEDEP}]
	>=dev-libs/libgusb-0.2.7[${MULTILIB_USEDEP}]
	>=media-libs/lcms-2.6:2=[${MULTILIB_USEDEP}]
	>=sys-auth/polkit-0.104
	virtual/udev
	virtual/libgudev:=[${MULTILIB_USEDEP}]
	virtual/libudev:=[${MULTILIB_USEDEP}]
	argyllcms? ( media-gfx/argyllcms )
	scanner? (
		media-gfx/sane-backends
		sys-apps/dbus )
	systemd? ( >=sys-apps/systemd-44:0= )
"
RDEPEND="${COMMON_DEPEND}
	!media-gfx/shared-color-profiles
	!<=media-gfx/colorhug-client-0.1.13
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-ns-stylesheets
	dev-libs/libxslt
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	extra-print-profiles? ( media-gfx/argyllcms )
	vala? ( $(vala_depend) )
"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

# According to upstream comment in colord.spec.in, building the extra print
# profiles requires >=4G of memory
CHECKREQS_MEMORY="4G"

pkg_pretend() {
	use extra-print-profiles && check-reqs_pkg_pretend
}

pkg_setup() {
	use extra-print-profiles && check-reqs_pkg_setup
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
}

src_prepare() {
	default

	use vala && vala_src_prepare

	# Adapt to Gentoo paths
	sed -i -e 's/spotread/argyll-spotread/' \
		src/sensors/argyll/cd-sensor-argyll.c || die
	sed -i -e "s/'colprof'/'argyll-colprof'/" \
		meson.build || die
	use vala && sed -i -e "s#'vapigen'#'${VAPIGEN}'#" \
		meson.build || die
}

multilib_src_configure() {
	# bash-completion test does not work on gentoo
	local emesonargs=(
		-Dbash_completion=false
		-Dsession_example=false
		-Dlibcolordcompat=true
		-Ddaemon=true
		-Ddaemon_user=colord
		-Dargyllcms_sensor=$(multilib_native_usex argyllcms true false)
		-Dprint_proafiles=$(multilib_native_usex extra-print-profiles true false)
		-Dreverse=false
		-Dvapi=$(multilib_native_usex vala true false)
		-Dsane=$(multilib_native_usex scanner true false)
		-Dsystemd=$(multilib_native_usex systemd true false)
	)

	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_test() {
	virtx meson_src_test
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	einstalldocs

	newbashcomp data/colormgr colormgr

	# Ensure config and profile directories exist and /var/lib/colord/*
	# is writable by colord user
	keepdir /var/lib/color{,d}/icc
	fowners colord:colord /var/lib/colord{,/icc}

	if use examples; then
		docinto examples
		dodoc examples/*.c
	fi
}
