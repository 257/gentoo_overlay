# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/dwm/dwm-6.0.ebuild,v 1.13 2014/11/20 11:47:14 jer Exp $

EAPI=5

SCM="git-r3"
EGIT_REPO_URI="git://git.suckless.org/${PN}"

inherit eutils savedconfig toolchain-funcs ${SCM}

DESCRIPTION="a dynamic window manager for X11"
HOMEPAGE="http://dwm.suckless.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="xinerama savedconfig"

RDEPEND="
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="
	${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )
"

src_prepare() {
	einfo "Git apply"
	git apply ${FILESDIR}/no_xinerama-fix_path.diff || die 
	sed -i \
		-e "s/CFLAGS = -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall/" \
		-e "/^LDFLAGS/{s|=|+=|g;s|-s ||g}" \
		config.mk || die
	sed -i \
		-e '/@echo CC/d' \
		-e 's|@${CC}|$(CC)|g' \
		Makefile || die

	restore_config config.h
	epatch_user
}

src_compile() {
	if use xinerama; then
		emake CC=$(tc-getCC) dwm
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" dwm
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/dwm-session2 dwm

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/dwm.desktop

	dodoc README

	if use savedconfig; then
	  save_config config.h
	fi
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
	if ! has_version x11-misc/dmenu; then
		elog "Installing ${PN} without x11-misc/dmenu"
		einfo "To have a menu you can install x11-misc/dmenu"
	fi
	einfo "You can custom status bar with a script in HOME/.dwm/dwmrc"
	einfo "the ouput is redirected to the standard input of dwm"
	einfo "Since dwm-5.4, status info in the bar must be set like this:"
	einfo "xsetroot -name \"\`date\` \`uptime | sed 's/.*,//'\`\""
}
