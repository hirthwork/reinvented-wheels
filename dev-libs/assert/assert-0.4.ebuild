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
S="${WORKDIR}/hirthwork-${PN}-1a65864"

src_install() {
	insinto /usr/include/assert
	doins abortassert.hpp || die "install failed"
	doins baseassert.hpp || die "install failed"
	doins constexpr.hpp || die "install failed"
	doins emptyassert.hpp || die "install failed"
	doins noexcept.hpp || die "install failed"
	doins nullarypredicates.hpp || die "install failed"
	doins stdexceptassert.hpp || die "install failed"
}

