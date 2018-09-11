# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit meson multilib-minimal git-r3

DESCRIPTION="Frame rate limiter for Linux/OpenGL/Vulkan"
HOMEPAGE="https://gitlab.com/torkel104/libstrangle"
EGIT_REPO_URI="https://gitlab.com/torkel104/libstrangle.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    virtual/opengl
    dev-util/vulkan-headers
"
RDEPEND="${DEPEND}"

PATCHES=(
    "${FILESDIR}/meson.patch"
)

multilib_src_configure() {
    local emesonargs=(
        --unity=on
    )

    meson_src_configure
}

multilib_src_install() {
    meson_src_install
}

multilib_src_install_all() {
    newbin src/strangle.sh strangle

    einstalldocs
}
