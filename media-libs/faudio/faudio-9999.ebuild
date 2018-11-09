# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit meson multilib-minimal

DESCRIPTION="Accuracy-focused XAudio reimplementation for open platforms"
HOMEPAGE="https://fna-xna.github.io/"

if [[ ${PV} == "9999" ]] ; then
        EGIT_REPO_URI="https://github.com/FNA-XNA/FAudio.git"
        EGIT_BRANCH="master"
        inherit git-r3
        SRC_URI=""
else
        ECOMMIT="067109ff9553f4941a3fc15f4bc38531ce2302b3"
        SRC_URI="https://github.com/FNA-XNA/FAudio/archive/${ECOMMIT}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64 ~x86"
        S="${WORKDIR}/${PN}-${ECOMMIT}"
fi


LICENSE="ZLIB"
SLOT="0"
IUSE="+ffmpeg +xnasong"

RESTRICT+=" mirror test"


RDEPEND="media-libs/libsdl2[${MULTILIB_USEDEP}]
	ffmpeg? ( media-video/ffmpeg[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/0001-Initial-meson-build-system-support.patch"
)

multilib_src_configure() {
    local emesonargs=(
        $(meson_use ffmpeg enable_ffmpeg)
        $(meson_use xnasong enable_xnasong)
    )
    meson_src_configure
}

multilib_src_install() {
    meson_src_install
}
