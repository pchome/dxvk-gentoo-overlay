# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils git-r3

DESCRIPTION="FUSE implementation for overlayfs"

HOMEPAGE="https://github.com/containers/fuse-overlayfs"
EGIT_REPO_URI="https://github.com/containers/fuse-overlayfs"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-fs/fuse:3"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf

	default
}
