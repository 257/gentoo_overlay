# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/heirloom-devtools/heirloom-devtools-999999.ebuild,v 1.4 2013/06/25 12:33:01 ryao Exp $

EAPI="5"

inherit eutils toolchain-funcs flag-o-matic


DESCRIPTION="Original UNIX development tools"
HOMEPAGE="http://heirloom.sourceforge.net/devtools.html"

EGIT_REPO_URI="git://github.com/n-t-roff/heirloom-doctools.git"
inherit git-r3 autotools-utils
SRC_URI=
KEYWORDS=

LICENSE="BSD BSD-4 CDDL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-shells/heirloom-sh"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/${PN}"

src_prepare() {

	sed -i \
		-e "s:^\(PREFIX=\)\(.*\):\1${EPREFIX}/usr:" \
		-e "s:^#\(LDFLAGS=\):\1${LDFLAGS}:" \
		-e "s:^#\(CFLAGS=\)\(.*\):\1${CFLAGS}:" \
		-e 's:^\(STRIP=\)\(.*\):\1true:' \
		-e "s:^\(CPPFLAGS = \)\(.*\):\1$(tc-getCXX):" \
		-e "s:^\(INSTALL=\)\(.*\):\1$(which install):" \
		./mk.config

	echo "CC=$(tc-getCC)" >> "./mk.config"

}

src_configure() { :; }

src_compile() {
	emake -j1
}

src_install() {
	emake ROOT="${D}" install
}

pkg_postinst() {
	elog "You may want to add /usr/5bin or /usr/ucb to \$PATH"
	elog "to enable using the apps of heirloom toolchest by default."
	elog "Man pages are installed in /usr/share/man/5man/"
	elog "You may need to set \$MANPATH to access them."
}
