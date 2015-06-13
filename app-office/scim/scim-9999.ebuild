# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pulseaudio/pulseaudio-6.0.ebuild,v 1.10 2015/05/07 18:53:47 pacho Exp $

EAPI=5

DESCRIPTION="SCIM - Spreadsheet Calculator Improvised - SC fork"
HOMEPAGE="https://github.com/andmarti1424/scim"
inherit git-r3
EGIT_REPO_URI="git://github.com/andmarti1424/scim"
EGIT_BRANCH="dev"

SLOT="0"
LICENSE="custom"
KEYWORDS="~amd64"

IUSE=""
S="${S}/src"
