EAPI=6

inherit multilib unpacker

DESCRIPTION="Official Runescape native client launcher"
HOMEPAGE="http://www.runescape.com"

SRC_URI="
	amd64? (
		http://content.runescape.com/downloads/ubuntu/pool/non-free/r/runescape-launcher/runescape-launcher_${PV}_amd64.deb
	)
"

SLOT="0"

IUSE="kde"

KEYWORDS="-* ~amd64"

LICENSE="RuneScape-EULA"
RESTRICT="bindist mirror strip"

S="${WORKDIR}"

RDEPEND="
	media-libs/libsdl2
	media-libs/glew
	media-libs/libvorbis
	net-libs/webkit-gtk
	net-misc/curl
"

pkg_nofetch() {
	eerror "Please wait 24 hours and sync your portage tree before reporting fetch failures."
}

src_prepare() {
	sed -i "s:/usr/share/games/$PN:/usr/libexec:" usr/bin/$PN

	eapply_user
}

src_install() {
	dobin usr/bin/$PN
	dodoc usr/share/doc/$PN/*

	exeinto /usr/libexec
	doexe usr/share/games/$PN/runescape

	insinto /usr/share/applications
	doins usr/share/applications/${PN}.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/hicolor

	if use kde ; then
		insinto /usr/share/kde4
		doins -r usr/share/kde4/services
	fi
}
