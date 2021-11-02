# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

DESCRIPTION="cifsd kernel server userspace utilities"
HOMEPAGE="https://github.com/cifsd-team/ksmbd-tools"
#SRC_URI="https://github.com/cifsd-team/${PN}/releases/download/${PV}/${P}.tgz"
# for now, use a snapshot to have the unit file
HASH=a1144518d74a26e0a45c0c1685f56f0f695bb497
SRC_URI="https://github.com/cifsd-team/${PN}/archive/${HASH}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kerberos"

DEPEND="
	dev-libs/glib
	dev-libs/libnl:3
	kerberos? ( virtual/krb5 )
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${HASH}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable kerberos krb5)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" install

	einstalldocs
	dodoc smb.conf.example Documentation/configuration.txt

	sed -i -e "s:/sbin:${EPREFIX}/usr/sbin:g" ksmbd.service
	systemd_dounit ksmbd.service
}
