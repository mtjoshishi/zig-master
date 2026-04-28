function check_version_zig_master() {
  local url="https://ziglang.org"
  local index_json="$(curl -s "${url}/download/index.json")"
  local _zigver="$(jq -r '."master"."version"' <<< "${index_json}")"
  local sha256sums="$(jq -r '."master"."src"."shasum"' <<< "${index_json}")"

  # Fetch current version
  local current="$(pacman -Q zig | awk '{print $2}' | sed 's/_/-/g; s/+g/+/g; s/-[0-9]$//g')"
  echo "Current: ${current}"
  if [ "$_zigver" = "$current" ]; then
    echo "zig-master: no update"
  else
    echo "zig-master: new version ${_zigver} (sha256sums: ${sha256sums}) is available"

    # Backup
    cp PKGBUILD PKGBUILD.bak
    sed -i -E "s/^_pkgver=.+/_pkgver=$_zigver/g" PKGBUILD
    sed -i -E "s/^sha256sums=.+/sha256sums=\('$sha256sums'\)/g" PKGBUILD

    makepkg --printsrcinfo > .SRCINFO
    echo "Update PKGBUILD"
  fi
}

check_version_zig_master
