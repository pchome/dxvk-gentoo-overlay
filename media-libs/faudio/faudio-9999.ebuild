# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit cmake-multilib

DESCRIPTION="Accuracy-focused XAudio reimplementation for open platforms"
HOMEPAGE="https://fna-xna.github.io/"

EGIT_REPO_URI="https://github.com/FNA-XNA/FAudio.git"
inherit git-r3

LICENSE="ZLIB"
SLOT="0"
IUSE="debug ffmpeg xnasong"

RDEPEND=">=media-libs/libsdl2-2.0.9[${MULTILIB_USEDEP}]
	ffmpeg? ( media-video/ffmpeg[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

multilib_src_configure() {
    local mycmakeargs=(
        -DFFMPEG=$(usex ffmpeg)
        -DXNASONG=$(usex xnasong)
        -DFORCE_ENABLE_DEBUGCONFIGURATION=$(usex debug)
        -DLOG_ASSERTIONS=$(usex debug)
    )
    cmake-utils_src_configure
}
