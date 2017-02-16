# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="github.com/ncw/${PN}"

inherit golang-vcs-snapshot golang-build

DESCRIPTION="rsync for cloud storage"
HOMEPAGE="http://rclone.org"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

src_prepare() {
	default

	# Mangle makefile to remove the need to be in a git clone
	sed -i \
		'/^TAG/d; /^LAST_TAG/d; /^NEW_TAG/d; /^BETA_URL/d' \
		src/${EGO_PN}/Makefile
}

src_test() {
	cd src/${EGO_PN} || die

	export GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)"

	emake quicktest || die "test failed"
}

src_compile() {
	cd src/${EGO_PN} || die

	export GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)"

	emake rclone || die "build failed"
}

src_install() {
	cd "${S}/src/${EGO_PN}"

	doman "${PN}.1"

	dodoc -r docs/content/*

	dobin "${S}/bin/${PN}" || die
}
