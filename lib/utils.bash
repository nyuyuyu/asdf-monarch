#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/Dropsource/monarch"
TOOL_NAME="monarch"
TOOL_TEST="monarch --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

monarch_download_base_url() {
	local version="$1"

	case "$version" in
	1.*)
		echo "https://d2dpq905ksf9xw.cloudfront.net"
		;;
	*)
		echo "https://d148mrbia1nlbw.cloudfront.net"
		;;
	esac
}

platform() {
	case "$(uname -s)" in
	"Darwin")
		echo "macos"
		;;
	"Linux")
		echo "linux"
		;;
	*)
		fail "Unsupported platform"
		;;
	esac
}

platform_extension() {
	case "$(uname -s)" in
	"Linux")
		echo "tar.xz"
		;;
	*)
		echo "zip"
		;;
	esac
}

platform_tar() {
	case "$(uname -s)" in
	"Darwin")
		echo "bsdtar"
		;;
	*)
		echo "tar"
		;;
	esac
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		grep -v "\-pre" | grep -v \.pre |
		grep -E '^(binaries|monarch-binaries)-'
}

list_all_versions() {
	list_github_tags | sed -E 's/^(binaries|monarch-binaries)-//'
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$(monarch_download_base_url "$version")/$(platform)/monarch_$(platform)_${version}.$(platform_extension)"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"
	local bin_path="$install_path/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$bin_path/$tool_cmd" || fail "Expected $bin_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
