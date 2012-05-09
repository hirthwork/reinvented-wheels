# Copyright 2011 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="lazy assertions classes"
HOMEPAGE="https://github.com/hirthwork/${PN}"
SRC_URI="https://github.com/hirthwork/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/hirthwork-${PN}-ee12e86"

RDEPEND=">=dev-libs/enableif-0.3"

src_install() {
	insinto /usr/include/assert
	doins abort.hpp || die "install failed"
	doins constexpr.hpp || die "install failed"
	doins empty.hpp || die "install failed"
	doins noexcept.hpp || die "install failed"
	doins predicates.hpp || die "install failed"
	doins stdexcept.hpp || die "install failed"
}

