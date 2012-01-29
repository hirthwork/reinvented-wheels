# Copyright 2011, 2012 Dmitry Potapov
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator

DESCRIPTION="Mock object construction toolkit"
HOMEPAGE="https://github.com/analizer/${PN}"
SRC_URI="https://github.com/analizer/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test doc stlport static-libs debug"
DOCS="AUTHORS COPYING README"
S="${WORKDIR}/analizer-${PN}-c307b2c"

RDEPEND="
	stlport? (
		dev-util/stlport-jam
		static-libs? ( dev-libs/backtrace ) )
	!stlport? (
		static-libs? ( dev-libs/backtrace[-stlport] ) )
	!static-libs? ( dev-libs/backtrace )
	dev-libs/enableif
	dev-libs/range"

DEPEND="dev-util/boost-build
	test? ( dev-libs/boost )
	doc? ( dev-util/noweb dev-tex/latexmk )
	${RDEPEND}"

src_compile()
{
	BOOST_BUILD_VERSION="$(best_version dev-util/boost-build)"
	BJAM_DOTTED_VERSION="$(get_version_component_range 1-2 ${BOOST_BUILD_VERSION#dev-util/boost-build-})"
	BJAM_VERSION="$(replace_all_version_separators _ ${BJAM_DOTTED_VERSION})"

	if use doc || use stlport
	then
		export BOOST_BUILD_PATH="/usr/share/reinvented-wheels:/usr/share/boost-build-${BJAM_VERSION}"
	fi

	LINK="shared"
	if use static-libs
	then
		LINK="${LINK},static"
	fi

	if use stlport
	then
		STDLIB="stlport"
	else
		STDLIB="native"
	fi

	if use debug
	then
		VARIANT="debug"
	else
		VARIANT="release"
	fi

	BJAM="bjam-${BJAM_VERSION}"
	OPTIONS="${VARIANT} link=${LINK} stdlib=${STDLIB}"

	${BJAM} ${OPTIONS} /${PN}//${PN} || die "build failed"

	if use doc
	then
		${BJAM} user-manual-install --prefix=. || die "Failed to generate doc"
		latexmk -pdf -quiet share/doc/${PN}/user-manual.tex || die "PDF generation failed"
	fi
}

src_test() {
	if use doc
	then
		${BJAM} ${OPTIONS} basic-test || die "build failed"
	else
		${BJAM} ${OPTIONS} test || die "build failed"
	fi
	elog "All tests passed"
}

src_install() {
	${BJAM} ${OPTIONS} /${PN}//${PN}-install --prefix=${D}/usr || die "install failed"

	if use doc
	then
		${BJAM} user-manual-install --prefix=${D}/usr || die "Failed to install doc"
		insinto /usr/share/doc/${PN}
		doins user-manual.pdf
	fi
}

