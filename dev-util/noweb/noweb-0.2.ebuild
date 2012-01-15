# Copyright 2012 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="BJam generator for code chunks and TeX documentation"
HOMEPAGE="https://github.com/analizer/${PN}"
SRC_URI="https://github.com/analizer/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
S="${WORKDIR}/analizer-${PN}-8f0c3e5"

RDEPEND="dev-util/boost-build
app-text/noweb"

src_install() {
	insinto /usr/share/reinvented-wheels
	doins noweb.jam
}

