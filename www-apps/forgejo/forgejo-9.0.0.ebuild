# Copyright 2016-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps go-module tmpfiles systemd flag-o-matic user-info

DESCRIPTION="A painless self-hosted Git service. Gitea fork drop-in replacement"
HOMEPAGE="https://forgejo.org/ https://codeberg.org/forgejo/forgejo"

MY_PV="${PV/_p/-}"
MY_P="${PN}-src-${MY_PV}"
SRC_URI="https://codeberg.org/forgejo/forgejo/releases/download/v${MY_PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
IUSE="+acct pam sqlite pie"

DEPEND="
	acct? (
		acct-group/git
		acct-user/git[gitea] )
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	dev-vcs/git
	!www-apps/gitea"
BDEPEND=">=dev-lang/go-1.23.2:="

DOCS=(
	custom/conf/app.example.ini CONTRIBUTING.md README.md
)
FILECAPS=(
	-m 711 cap_net_bind_service+ep usr/bin/gitea
)

RESTRICT="test"

src_prepare() {
	default

	sed -i -e "s#^MODE = console#MODE = file#" custom/conf/app.example.ini || die
}

src_configure() {
	# bug 832756 - PIE build issues
	filter-flags -fPIE
	filter-ldflags -fPIE -pie
}

src_compile() {
	local gitea_tags
	local -a gitea_settings makeenv

	# The space-separated list of the -tags flag is deprecated, please
	# always use the comma-separated list in the future.
	gitea_tags="bindata"
	gitea_tags+="$(usex pam ',pam' '')"
	gitea_tags+="$(usex sqlite ',sqlite,sqlite_unlock_notify' '')"
	
	gitea_settings=(
		"-X code.gitea.io/gitea/modules/setting.CustomConf=${EPREFIX}/etc/gitea/app.ini"
		"-X code.gitea.io/gitea/modules/setting.CustomPath=${EPREFIX}/var/lib/gitea/custom"
		"-X code.gitea.io/gitea/modules/setting.AppWorkPath=${EPREFIX}/var/lib/gitea"
	)

	makeenv=(
		LDFLAGS="-extldflags \"${LDFLAGS}\" ${gitea_settings[*]}"
		TAGS="${gitea_tags}"
	)

	if use pie ; then
		# Please check the supported platforms when a new keyword request opened,
		# refer to file: 'go/src/internal/platform/supported.go'.
		# When PIE buildmode is not supported by internal linker, the external
		# linker will be used automatically, refer to:
		# https://github.com/golang/go/blob/ed817f1c4055a559a94afffecbb91c78e4f39942/src/cmd/link/internal/ld/config.go#L149
		makeenv+=( EXTRA_GOFLAGS="-buildmode=pie" )
	fi

	env "${makeenv[@]}" emake backend
}

src_install() {
	dobin gitea

	einstalldocs

	newconfd "${FILESDIR}/gitea.confd-r1" gitea
	newinitd "${FILESDIR}/gitea.initd-r3" gitea
	newtmpfiles - gitea.conf <<-EOF
		d /run/gitea 0755 git git
	EOF
	systemd_newunit "${FILESDIR}"/gitea.service-r4 gitea.service

	insinto /etc/gitea
	newins custom/conf/app.example.ini app.ini
	if use acct; then
		fowners root:git /etc/gitea/{,app.ini}
		fperms g+w,o-rwx /etc/gitea/{,app.ini}

		diropts -m0750 -o git -g git
		keepdir /var/lib/gitea /var/lib/gitea/custom /var/lib/gitea/data
		keepdir /var/log/gitea
	fi
}

pkg_postinst() {
	fcaps_pkg_postinst

	# It is not guaranteed that the git user and group always exist (due to the acct USE Flag),
	# but for convenience, the tmpfile uses the git user and group by default.
	# To avoid installation errors, a condition needs to be added here:
	#   if there is no git user or group, the installation of tmpfile will be skipped
	#   and the user will be notified to handle it by themselves.
	if egetent passwd git &>/dev/null && \
		egetent group git &>/dev/null; then
		tmpfiles_process gitea.conf
	else
		eerror "Unable to install the tmpfile for gitea due to the git user or group is missing,"
		eerror "please install tmpfile manually or rebuild this package with USE flag 'acct'."
		eerror "You can simply copy the default tmpfile from '/usr/lib/tmpfiles.d/gitea.conf'"
		eerror "to higher priority path '/etc/tmpfiles.d/gitea.conf', and correct it with"
		eerror "the right User and Group value (see tmpfiles.d(5) for details), then execute:"
		eerror "  # systemd-tmpfiles --create /etc/tmpfiles.d/gitea.conf"
		eerror "to install it."
	fi
}
