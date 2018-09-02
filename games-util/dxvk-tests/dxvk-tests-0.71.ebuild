# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit meson-winegcc multilib-minimal

DESCRIPTION="A Vulkan-based translation layer for Direct3D 10/11 (tests)"
HOMEPAGE="https://github.com/doitsujin/dxvk"

MY_P="${P/-tests/}"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/doitsujin/dxvk.git"
	EGIT_BRANCH="master"
	inherit git-r3
	SRC_URI=""
else
	SRC_URI="https://github.com/doitsujin/dxvk/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="-* ~amd64"
fi

S="${WORKDIR}/${MY_P}"
LICENSE="ZLIB"
SLOT=0
RESTRICT="test"

RDEPEND="
	|| (
		>=app-emulation/wine-vanilla-3.14:*[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-staging-3.14:*[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-d3d9-3.14:*[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-any-3.14:*[${MULTILIB_USEDEP},vulkan]
	)
	games-util/dxvk"

DEPEND="${RDEPEND}
	dev-util/glslang"

PATCHES=(
	"${FILESDIR}/dxvk-0.70-option-for-utils.patch"
	"${FILESDIR}/dxvk-0.71-fix-tests.patch"
	"${FILESDIR}/dxvk-0.70-tests-only.patch"
	"${FILESDIR}/dxvk-0.70-winelib-wrapper.patch"
)

dxvk_check_requirements() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		if ! tc-is-gcc || [[ $(gcc-major-version) -lt 7 || $(gcc-major-version) -eq 7 && $(gcc-minor-version) -lt 3 ]]; then
			die "At least gcc 7.3 is required"
		fi
	fi
}

pkg_pretend() {
	dxvk_check_requirements
}

pkg_setup() {
	dxvk_check_requirements
}

multilib_src_configure() {
	local emesonargs=(
		-Denable_tests=true
		-Denable_utils=false
		--unity=on
	)

	[[ ${ABI} == "x86" ]] && emesonargs+=( --bindir="$(get_libdir)/${PN}" )

	meson-winegcc_src_configure
}

multilib_src_install() {
	meson-winegcc_src_install
}
