# Copyright 2011 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="Implementation of set operations on range containers"
HOMEPAGE="https://github.com/hirthwork/${PN}"
SRC_URI="https://github.com/hirthwork/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/hirthwork-${PN}-752b377"

src_install() {
	insinto /usr/include/raingee
	doins emptyassert.hpp || die "install failed"
	doins predicates.hpp || die "install failed"
	doins range.hpp || die "install failed"
	doins rangeimpl.hpp || die "install failed"
}

