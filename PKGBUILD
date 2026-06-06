# Original Maintainer: Daurnimator <daurnimator@archlinux.org>
# Contributor: Marc Tiehuis <marctiehuis@gmail.com>
# Customized by Makoto Teramoto <mteramoto.knct@gmail.com>

pkgname=zig
_pkgver=0.17.0-dev.702+18b3c78a9
pkgver=$(echo "$_pkgver" | sed 's/-/_/g; s/+/+g/g')
pkgrel=1
pkgdesc='a general-purpose programming language and toolchain for maintaining robust, optimal, and reusable software'
arch=('x86_64')
url='https://ziglang.org/'
license=('MIT')
options=('!lto' '!debug')
depends=('clang' 'lld' 'llvm-libs')
groups=('modified')
makedepends=('cmake' 'llvm')
checkdepends=('lib32-glibc')
source=("https://ziglang.org/builds/zig-$_pkgver.tar.xz")
sha256sums=('abf2ec1e445b718f925d00e5600d91c7c9ff68e03c6d465aa768a4e4ed4c7769')

build() {
    cd "$pkgname-$_pkgver"

    local cmake_vars=(
        # Use clang
        CMAKE_C_COMPILER=$(which clang)
        CMAKE_CXX_COMPILER=$(which clang++)
        CMAKE_INSTALL_PREFIX=/usr
        CMAKE_PREFIX_PATH=$(llvm-config --prefix)

        # The zig CMakeLists uses build type Debug if not set
        # override it back to None so makepkg env vars are respected
        CMAKE_BUILD_TYPE=None

        # Force the path to lld to be specified to avoid SEGV error
        # caused by conflicts between llvm version.
        CMAKE_LINKER_TYPE=LLD
        CMAKE_C_USING_LINKER_LLD=/usr//bin/ld.lld
        CMAKE_CXX_USING_LINKER_LLD=/usr/bin/ld.lld

        ZIG_PIE=ON
        ZIG_SHARED_LLVM=ON
        ZIG_USE_LLVM_CONFIG=ON
        # ZIG_TARGET_TRIPLE=native-linux.6.12-gnu.2.40
        ZIG_TARGET_MCPU=baseline
    )
    cmake -B build "${cmake_vars[@]/#/-D}" .
    cmake --build build -j $(nproc --all)
}

package() {
    cd "$pkgname-$_pkgver"

    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

    DESTDIR="$pkgdir" cmake --install build
}

