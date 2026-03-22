# Original Maintainer: Daurnimator <daurnimator@archlinux.org>
# Contributor: Marc Tiehuis <marctiehuis@gmail.com>
# Customized by Makoto Teramoto <mteramoto.knct@gmail.com>

pkgname=zig
_pkgver=0.16.0-dev.2962+08416b44f
pkgver=$(echo "$_pkgver" | sed 's/-/_/g; s/+/+g/g')
pkgrel=1
pkgdesc='a general-purpose programming language and toolchain for maintaining robust, optimal, and reusable software'
arch=('x86_64')
url='https://ziglang.org/'
license=('MIT')
options=('!lto')
depends=('clang21' 'lld21' 'llvm21-libs')
groups=('modified')
makedepends=('cmake' 'llvm21')
checkdepends=('lib32-glibc')
source=("https://ziglang.org/builds/zig-$_pkgver.tar.xz")
sha256sums=('0237a37a540c9f7f06a48e1e29af7c00bfb8a4135adfd8ecd9910c27a4bf114d')

build() {
    cd "$pkgname-$_pkgver"

    local cmake_vars=(
        # Use clang
        CMAKE_C_COMPILER=/usr/lib/llvm21/bin/clang-21
        CMAKE_CXX_COMPILER=/usr/lib/llvm21/bin/clang++
        CMAKE_INSTALL_PREFIX=/usr
        CMAKE_PREFIX_PATH=/usr/lib/llvm21

        # The zig CMakeLists uses build type Debug if not set
        # override it back to None so makepkg env vars are respected
        CMAKE_BUILD_TYPE=None

        # Force the path to lld to be specified to avoid SEGV error
        # caused by conflicts between llvm version.
        CMAKE_LINKER_TYPE=LLD
        CMAKE_C_USING_LINKER_LLD=/usr/lib/llvm21/bin/ld.lld
        CMAKE_CXX_USING_LINKER_LLD=/usr/lib/llvm21/bin/ld.lld

        ZIG_PIE=ON
        ZIG_SHARED_LLVM=ON
        ZIG_USE_LLVM_CONFIG=ON
        # ZIG_TARGET_TRIPLE=native-linux.6.12-gnu.2.40
        ZIG_TARGET_MCPU=baseline
    )
    cmake -B build "${cmake_vars[@]/#/-D}" .
    cmake --build build
}

package() {
    cd "$pkgname-$_pkgver"

    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

    DESTDIR="$pkgdir" cmake --install build
}

