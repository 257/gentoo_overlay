# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dwb/dwb-9999.ebuild,v 1.10 2014/06/26 04:41:55 radhermit Exp $

EAPI=5

inherit git-r3 toolchain-funcs

EGIT_REPO_URI="https://bitbucket.org/portix/dwb.git"

DESCRIPTION="Dynamic web browser based on WebKit and GTK+"
HOMEPAGE="http://portix.bitbucket.org/dwb/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="examples gtk3 libsecret"

RDEPEND="
	>=net-libs/libsoup-2.38:2.4
	dev-libs/json-c
	net-libs/gnutls
	gtk3? (
		=net-libs/webkit-gtk-2.4.8:3
		x11-libs/gtk+:3
	)
	libsecret? ( app-crypt/libsecret )
"
#	!gtk3? (
#		>=net-libs/webkit-gtk-1.8.0:2
#		x11-libs/gtk+:2
#	)

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	#sed -i 's:webkit/webkit\.h:webkit2/webkit2\.h:' src/dwb.h || die
    #sed -i 's:webkitgtk-3:webkit2gtk-4:' config.mk || die
	#sed -i "/^CFLAGS += -\(pipe\|g\|O2\)/d" config.mk || die
	git apply ${FILESDIR}/${P}.diff || die
	epatch ${FILESDIR}/gtk_deprecated.patch
}

src_compile() {
	local myconf
	use gtk3 && myconf+=" GTK=3"
	! use libsecret && myconf+=" USE_LIB_SECRET=0"

	emake CC="$(tc-getCC)" ${myconf}
}

src_install() {
	default

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
