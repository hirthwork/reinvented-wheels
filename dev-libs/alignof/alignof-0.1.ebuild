# Copyright 2011 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="boost::enable_if reinvented"
HOMEPAGE="https://github.com/hirthwork/${PN}"
SRC_URI="https://github.com/hirthwork/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/hirthwork-${PN}-b6e693d"

src_install() {
	insinto /usr/include/reinvented-wheels
	doins alignof.hpp || die "install failed"
}

