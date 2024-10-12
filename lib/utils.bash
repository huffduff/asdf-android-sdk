#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="android-sdk"
TOOL_TEST="sdkmanager --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

get_platform() {
    local silent=${1:-}
    local platform=""

    platform="$(uname | tr '[:upper:]' '[:lower:]')"

    case "$platform" in
    linux)
        echo "linux"
        ;;
	darwin)
		echo "mac"
		;;
    *)
        fail "Platform '${platform}' not supported!"
        ;;
    esac
}

cli() {
	local current_script_path cmd

	current_script_path=$(dirname $(realpath ${BASH_SOURCE[0]}))
	cmd="$current_script_path/cmdline-tools/bin/sdkmanager"

	(which java > /dev/null ) || (
		fail "Java is required to run $TOOL_NAME." \
			"If you are using the asdf-java plugin, be sure to set JAVA_HOME." \
			"see https://github.com/halcyon/asdf-java?tab=readme-ov-file#java_home"
	)
	
	"$cmd" --sdk_root="${current_script_path}/cmdline-tools" "$@"
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

parse_version_lines() {
	awk -F'|' '{ print $2 }' | tr -d '[:blank:]'
}

query_versions() {
	cli --list | grep cmdline-tools
}

list_all_versions() {
	query_versions | parse_version_lines | sort -n | uniq | tr '\n' ' '
}

download_release() {
	local version="$1"

	cli --install "cmdline-tools;$version" --sdk_root="$ASDF_DOWNLOAD_PATH" || fail "Failed to download $TOOL_NAME $version."
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"


	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="cmdline-tools/${ASDF_INSTALL_VERSION}/bin/sdkmanager"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

get_sdkmanager_url() {
	local platform
	platform="$(get_platform)"
	curl -s https://developer.android.com/studio\#command-tools | grep -Eo "https://dl.google.com/android/repository/commandlinetools-${platform}-[0-9]*_latest.zip" | head -n 1
}
