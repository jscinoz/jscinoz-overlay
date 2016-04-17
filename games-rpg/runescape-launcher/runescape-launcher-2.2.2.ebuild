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

#Depends: libsdl2-2.0-0 (>= 2.0.2+dfsg1-3ubuntu1.1), libglew1.10 (>= 1.10.0-3), libc6 (>= 2.19-0ubuntu6.6), libcurl3-gnutls (>= 7.35.0-1ubuntu2.5), libstdc++6 (>= 4.8.4-2ubuntu1~14.04), libgcc1 (>= 1:4.9.1-0ubuntu1), libvorbisenc2 (>= 1.3.2-1.3ubuntu1), libwebkitgtk-1.0-0 (>= 2.4.8-1ubuntu1~ubuntu14.04.1)

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

src_install() {
	dobin usr/bin/$PN
	dodoc usr/share/doc/$PN/*

	insinto /usr/share/games
	doins -r usr/share/games/$PN

	insinto /usr/share/applications
	doins usr/share/applications/${PN}.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/hicolor

	# TODO: install kde4 services conditional

	if use kde ; then
		insinto /usr/share/kde4
		doins -r usr/share/kde4/services
	fi
}
