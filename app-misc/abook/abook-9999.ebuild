# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/abook/abook-0.6.0_pre2.ebuild,v 1.9 2014/08/10 18:01:05 slyfox Exp $

EAPI=5

DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client"
HOMEPAGE="http://abook.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="nls"

BUILD_DIR="${WORKDIR}/${P}"

EGIT_REPO_URI="git://git.code.sf.net/p/${PN}/git"
inherit git-r3 autotools-utils
SRC_URI=
KEYWORDS=

RDEPEND="sys-libs/ncurses
	sys-libs/readline
	nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )"

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc BUGS ChangeLog FAQ README TODO sample.abookrc || die "dodoc failed"
}
