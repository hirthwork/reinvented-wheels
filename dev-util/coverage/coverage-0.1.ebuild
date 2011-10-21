# Copyright 2011 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="BJam <variant> feature extended with coverage one"
HOMEPAGE="https://github.com/analizer/${PN}"
SRC_URI="https://github.com/analizer/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DOCS="AUTHORS COPYING README TODO"
HASH="e78dabc"
S="${WORKDIR}/analizer-${PN}-${HASH}"

RDEPEND="dev-util/boost-build"

src_install() {
	insinto /usr/share/reinvented-wheels
	doins coverage.jam
}

