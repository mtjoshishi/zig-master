# Original Maintainer: Daurnimator <daurnimator@archlinux.org>
# Contributor: Marc Tiehuis <marctiehuis@gmail.com>
# Customized by Makoto Teramoto <mteramoto.knct@gmail.com>

pkgname=zig
_pkgver=0.16.0-dev.2145+ec25b1384
pkgver=$(echo "$_pkgver" | sed 's/-/_/g; s/+/+g/g')
pkgrel=1
pkgdesc='a general-purpose programming language and toolchain for maintaining robust, optimal, and reusable software'
arch=('x86_64')
url='https://ziglang.org/'
license=('MIT')
options=('!lto')
depends=('clang' 'lld' 'llvm-libs')
groups=('modified')
makedepends=('cmake' 'llvm')
checkdepends=('lib32-glibc')
source=("https://ziglang.org/builds/zig-$_pkgver.tar.xz")
sha256sums=('d96fa813f5b87ba6c8aababb549e5b555b3fecd4d1db214b6b77794590cc1554')

build() {
    cd "$pkgname-$_pkgver"

    local cmake_vars=(
        # Use clang
        CMAKE_C_COMPILER=$(which clang)
        CMAKE_CXX_COMPILER=$(which clang++)
        CMAKE_INSTALL_PREFIX=/usr
        CMAKE_PREFIX_PATH=/usr

        # The zig CMakeLists uses build type Debug if not set
        # override it back to None so makepkg env vars are respected
        CMAKE_BUILD_TYPE=None

        ZIG_PIE=ON
        ZIG_SHARED_LLVM=ON
        ZIG_USE_LLVM_CONFIG=ON
        # ZIG_TARGET_TRIPLE=native-linux.6.12-gnu.2.40
        ZIG_TARGET_MCPU=baseline
    )
    cmake -B build "${cmake_vars[@]/#/-D}" .
    cmake --build build --parallel $(($(nproc --all) - 2))
}

package() {
    cd "$pkgname-$_pkgver"

    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

    DESTDIR="$pkgdir" cmake --install build
}

