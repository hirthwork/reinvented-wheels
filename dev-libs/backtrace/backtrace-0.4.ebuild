# Copyright 2011 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="Library for program backtrace retrieval"
HOMEPAGE="https://github.com/analizer/${PN}"
SRC_URI="https://github.com/analizer/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test static-libs"
DOCS="AUTHORS COPYING README"
HASH="eb4e716"
S="${WORKDIR}/analizer-${PN}-${HASH}"

DEPEND="sys-devel/gcc[-nocxx]
	test? ( dev-libs/boost )
	dev-util/boost-build"

src_compile()
{
	BOOST_BUILD_VERSION="$(best_version dev-util/boost-build)"
	BJAM_DOTTED_VERSION="$(get_version_component_range 1-2 ${BOOST_BUILD_VERSION#dev-util/boost-build-})"
	BJAM="bjam-$(replace_all_version_separators _ ${BJAM_DOTTED_VERSION}) toolset=gcc"

	LINK="shared"
	if use static-libs
	then
		LINK="${LINK},static"
	fi

	${BJAM} release link=${LINK} || die "build failed"
}

src_test() {
	${BJAM} test || die "build failed"
	elog "All tests passed"
}

src_install() {
	${BJAM} release dist link=$LINK --prefix=${D}/usr || die "install failed"
}

