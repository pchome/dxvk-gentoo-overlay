# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit meson-winegcc multilib-minimal

DESCRIPTION="A D3D9 and D3D10 -> D3D11 Translation Layer"
HOMEPAGE="https://github.com/Joshua-Ashton/dxup"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Joshua-Ashton/dxup.git"
	EGIT_BRANCH="d3d9-dev"
	inherit git-r3
	SRC_URI=""
else
	SRC_URI="https://github.com/Joshua-Ashton/dxup/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64"
fi

LICENSE="ZLIB"
SLOT="${PV}"
IUSE="utils"

RDEPEND="
	|| (
		>=app-emulation/wine-vanilla-3.14:*[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-staging-3.14:*[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-d3d9-3.14:*[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-any-3.14:*[${MULTILIB_USEDEP},vulkan]
	)
	utils? ( app-emulation/winetricks )"

PATCHES=(
	"${FILESDIR}/dxup-ignore-unused-parts.patch"
)

dxup_check_requirements() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		if ! tc-is-gcc || [[ $(gcc-major-version) -lt 7 || $(gcc-major-version) -eq 7 && $(gcc-minor-version) -lt 3 ]]; then
			die "At least gcc 7.3 is required"
		fi
	fi
}

pkg_pretend() {
	dxup_check_requirements
}

pkg_setup() {
	dxup_check_requirements
}

src_prepare() {
	if use utils; then
	    cp "${FILESDIR}/setup.sh" "${T}/dxup-setup-${PV}"
		cp "${FILESDIR}/setup_dxup_winelib.verb" "${T}"
		sed -e "s/@verb_location@/${EPREFIX}\/usr\/share\/dxup-${PV}/" -i "${T}/dxup-setup-${PV}" || die
	fi

	default
}

multilib_src_configure() {
	local emesonargs=(
		--libdir="$(get_libdir)/dxup-${PV}"
		--bindir="$(get_libdir)/dxup-${PV}/bin"
		--unity=on
	)
	meson-winegcc_src_configure

	if use utils; then
		sed -e "s/@dll_dir_${ABI}@/${EPREFIX}\/usr\/$(get_libdir)\/dxup-${PV}/" -i "${T}/setup_dxup_winelib.verb" || die
    fi
}

multilib_src_install() {
	meson-winegcc_src_install
}

multilib_src_install_all() {
    if use utils; then
		if [[ ${PV} == "9999" ]]; then
			sed -e "s/@is_git_ver@/1/" -i "${T}/setup_dxup_winelib.verb" || die
		fi

		# clean undefined
		sed -e "s/@.*@//" -i "${T}/setup_dxup_winelib.verb" || die

	    # install winetricks verb
	    insinto "/usr/share/dxup-${PV}"
	    doins "${T}/setup_dxup_winelib.verb"

	    # create combined setup helper
	    exeinto /usr/bin
	    doexe "${T}/dxup-setup-${PV}"
    fi

    einstalldocs
}
