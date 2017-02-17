# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="github.com/ncw/${PN}"

inherit golang-build

if [[ ${PV} = *9999* ]]; then
	# We need to fetch with git directly (rather than via go get) since we
	# simply use upstream's Makefile
	EGIT_REPO_URI="https://${EGO_PN}.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/src/${EGO_PN}"

	inherit git-r3
else
	KEYWORDS="~amd64 ~x86 ~arm"
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

	inherit golang-vcs-snapshot
fi

DESCRIPTION="rsync for cloud storage"
HOMEPAGE="http://rclone.org"

LICENSE="MIT"
SLOT="0"

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

	cp -sR "$(go env GOROOT)" "${T}/goroot" || die
	rm -rf "${T}/goroot/src/${EGO_PN}" || die
	rm -rf "${T}/goroot/pkg/$(go env GOOS)_$(go env GOARCH)/${EGO_PN}" || die

	export GOROOT="${T}/goroot"
	export GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)"

	emake rclone || die "build failed"
}

src_install() {
	cd "${S}/src/${EGO_PN}"

	doman "${PN}.1"

	dodoc -r docs/content/*

	dobin "${S}/bin/${PN}" || die
}
