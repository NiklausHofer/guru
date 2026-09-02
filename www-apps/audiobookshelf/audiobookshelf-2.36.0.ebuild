# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# See dev-util/bash-language-server for how to do this.

EAPI=8

DESCRIPTION="Self-hosted audiobook and podcast server"
HOMEPAGE="https://audiobookshelf.org"
# 1. Download tar.gz file from GitHub
# 2. Run npm --cache ./npm-cache install v2.36.0.tar.gz
# 3. Run tar -caf audiobookshelf-2.36.0-deps.tar.xz npm-cache
SRC_URI="
	https://github.com/advplyr/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://vimja.cloud/public.php/dav/files/z59eKDyLFokW2KK/${CATEGORY}/${PN}/${P}-deps.tar.xz
"
#S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND=""
RDEPEND="
	net-libs/nodejs
	media-video/ffmpeg
"

#src_unpack(){
#	cd "${T}" || die
#	unpack ${P}-deps.tar.xz
#}

src_compile(){
	cd client || die
	#npm ci --unsafe-perm=true --allow-root --verbose --offline --cache "${T}/npm-cache" --progress false --only=production
	#echo "Will now install the client"
	#npm ci --unsafe-perm=true --allow-root --verbose --offline --cache "${T}/npm-cache" --progress false
    npm \
    	--offline \
    	--verbose \
    	--progress false \
    	--foreground-scripts \
    	--global \
    	--prefix "${ED}"/usr \
    	--cache "${T}/npm-cache" \
		--only=production \
		install || die
	echo "will now generate"
	npm run generate --offline --cache "${T}/npm-cache" --progress false --verbose || die
	cd .. || die

    npm \
    	--offline \
    	--verbose \
    	--progress false \
    	--foreground-scripts \
    	--global \
    	--prefix "${ED}"/usr \
    	--cache "${T}/npm-cache" \
    	--only=production \
		install || die
}

#src_install(){
#
#	#npm \
#	#	--offline \
#	#	--verbose \
#	#	--progress false \
#	#	--foreground-scripts \
#	#	--global \
#	#	--prefix "${ED}"/usr \
#	#	--cache "${T}/npm-cache" \
#	#	--only=production \
#	#	install "${DISTDIR}"/${P}.tar.gz || die
#
#	#cd "${ED}"/usr/$(get_libdir)/node_modules/${PN} || die
#	#einstalldocs
#}

#src_test(){
#	cd "${S}" || die
#	tar xf "${DISTDIR}"/${P}.tar.gz || die
#    cd "${P}" || die
#	npm \
#		--offline \
#		--verbose \
#		--progress false \
#		--foreground-scripts \
#		--global \
#		--cache "${T}/npm-cache" \
#		test || die
#}
