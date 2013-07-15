# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 wxwidgets

DESCRIPTION="Open source free form data organizer"

HOMEPAGE="http://www.treesheets.com"

EGIT_REPO_URI="git://github.com/aardappel/treesheets.git"

LICENSE="ZLIB"

SLOT="0"

DEPEND="x11-libs/wxGTK:2.9[X]"

RDEPEND="${DEPEND}"
WX_GTK_VER="2.9"

src_prepare() {
	epatch "${FILESDIR}/${P}-fixpaths.patch"
	cp "${FILESDIR}"/Makefile . || die
	mkdir obj bin || die
	tc-export CXX
}
