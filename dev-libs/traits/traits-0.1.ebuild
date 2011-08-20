# Copyright 2011 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="Implementaton of userful traits"
HOMEPAGE="https://github.com/analizer/${PN}"
SRC_URI="https://github.com/analizer/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test"
DOCS="AUTHORS COPYING README TODO"
HASH="73f3943"
S="${WORKDIR}/analizer-${PN}-${HASH}"

DEPEND=">=sys-devel/gcc-4.6.0[-nocxx]
	test? ( dev-libs/boost )
	dev-util/boost-build"

src_test() {
	BOOST_BUILD_VERSION="$(best_version dev-util/boost-build)"
	BJAM_DOTTED_VERSION="$(get_version_component_range 1-2 ${BOOST_BUILD_VERSION#dev-util/boost-build-})"
	BJAM="bjam-$(replace_all_version_separators _ ${BJAM_DOTTED_VERSION})"

	GCC_VERSION="$(best_version sys-devel/gcc)"
	GCC_VERSION="${GCC_VERSION#sys-devel/gcc-}"
	GCC_PROFILE="${CHOST}-${GCC_VERSION/_/-}"
	eval $(gcc-config -E ${GCC_PROFILE})
	export LD_LIBRARY_PATH=$(gcc-config -L ${GCC_PROFILE})

	elog "Starting tests"
	${BJAM} test || die "test failed"
	elog "All tests passed"
}

src_install() {
	# best_version can't be called from global scope, so this is duplicated
	BOOST_BUILD_VERSION="$(best_version dev-util/boost-build)"
	BJAM_DOTTED_VERSION="$(get_version_component_range 1-2 ${BOOST_BUILD_VERSION#dev-util/boost-build-})"
	BJAM="bjam-$(replace_all_version_separators _ ${BJAM_DOTTED_VERSION})"

	${BJAM} dist --prefix=${D}/usr || die "install failed"
}

