# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Forgejo actions runner"
HOMEPAGE="https://code.forgejo.org/forgejo/runner"
SRC_URI="https://code.forgejo.org/forgejo/runner/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/runner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pie"

DEPEND="
	acct-group/gitlab-runner
	acct-user/gitlab-runner
	app-containers/docker
"
RDEPEND="${DEPEND}"

src_compile() {
	LDFLAGS="-extldflags \"${LDFLAGS}\""
	if use pie ; then
		GOFLAGS+="-buildmode=pie"
	fi

	emake build
}

src_install() {
	dobin forgejo-runner

	systemd_newunit "${FILESDIR}"/forgejo-runner.service forgejo-runner.service
}

pkg_postinst() {
	einfo "To register the daemon, please do it in the gitlab-runner working directory"
	einfo "cd /var/lib/gitlab-runner/"
	einfo "sudo -u gitlab-runner forgejo-runner register --name myrunner --no-interactive --instance http://{XXX}:3000 --token {TOKEN}"
}
