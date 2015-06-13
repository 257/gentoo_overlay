# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="BBC Iplayer downloading application"
HOMEPAGE="http://linuxcentre.net/get_iplayer/"
#EGIT_REPO_URI="git://git.infradead.org/${P}.git"
EGIT_REPO_URI="git://github.com/get-iplayer/${PN}.git"
EGIT_BRANCH='develop'
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="media-video/ffmpeg
  media-video/rtmpdump
  dev-perl/libwww-perl"
DEPEND=""

src_install() {
	dobin ${PN}
	doman ${PN}.1
	insinto /usr/share/${PN}/plugins
	doins plugins/*
}

