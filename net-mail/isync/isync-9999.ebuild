# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/isync/isync-1.0.6.ebuild,v 1.3 2013/02/24 11:25:37 ago Exp $

EAPI=5

DESCRIPTION="MailDir mailbox synchronizer"
HOMEPAGE="http://isync.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"

#if LIVE
  EGIT_REPO_URI="git://git.code.sf.net/p/isync/isync"
  inherit git-r3 autotools
  KEYWORDS=""
#endif

inherit eutils 

IUSE="ssl"

RDEPEND=">=sys-libs/db-4.2
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="dev-perl/TimeDate
	${RDEPEND}"

#if LIVE
src_prepare () {	
  eautoreconf
}
#endif

src_configure () {
	econf $(use_with ssl)
}

src_install()
{
	emake DESTDIR="${D}" install
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF} || die
}
