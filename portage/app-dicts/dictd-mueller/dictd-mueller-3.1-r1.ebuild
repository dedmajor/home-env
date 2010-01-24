# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

MY_PN="mueller-dict"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="V. K. Mueller English-Russian Dictionary"
HOMEPAGE="http://mueller-dict.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="noipa preformat"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

RESTRICT="mirror"

DEPEND=">=app-text/dictd-1.8.0
	preformat? ( dev-lang/perl )
	!noipa? ( !preformat? ( dev-lang/perl ) )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack "${A}"
	if use !noipa || use preformat; then
		has_version ">=app-text/dictd-1.10.1" && epatch ${FILESDIR}/${P}-dictfmt.patch
		rm -f ${S}/dict/*.dz ${S}/dict/*.index
	fi
}

src_compile() {
	eautoreconf || "autoreconf failed"
	econf \
	$(use_enable !noipa IPA-unicode) \
	$(use_enable preformat) || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	cd ${S}/dict
	insinto /usr/lib/dict
	doins mueller-{abbrev,base,dict,geo,names}.{dict.dz,index} || die "installation failed"
}
