# Copyright 2012 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="BJam <stdlib> feature extended with stlport"
HOMEPAGE="https://github.com/hirthwork/${PN}"
SRC_URI="https://github.com/hirthwork/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
S="${WORKDIR}/hirthwork-${PN}-c877d2d"

RDEPEND="dev-util/boost-build
	dev-libs/STLport"

src_install() {
	insinto /usr/share/reinvented-wheels
	doins stlport.jam || die "install failed"
	insinto /usr/share/stlport-jam
	doins Jamroot || die "install failed"
}

