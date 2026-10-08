#!/bin/sh
# Builds a Release "Quick Symlink.app" into build/.
#
#   Scripts/build-app.sh                          # signed to run on this Mac only
#   DEVELOPMENT_TEAM=XXXXXXXXXX Scripts/build-app.sh   # signed with your Apple Development certificate
set -eu

cd "$(dirname "$0")/.."
derived_data="$(mktemp -d)"
trap 'rm -rf "$derived_data"' EXIT

set -- -project "Quick Symlink.xcodeproj" -scheme "Quick Symlink" -configuration Release -derivedDataPath "$derived_data"
if [ -n "${DEVELOPMENT_TEAM:-}" ]; then
    set -- "$@" -allowProvisioningUpdates DEVELOPMENT_TEAM="$DEVELOPMENT_TEAM" CODE_SIGN_IDENTITY="Apple Development"
fi

if ! xcodebuild "$@" build > "$derived_data/build.log" 2>&1; then
    tail -n 50 "$derived_data/build.log"
    exit 1
fi

rm -rf "build/Quick Symlink.app"
mkdir -p build
ditto "$derived_data/Build/Products/Release/Quick Symlink.app" "build/Quick Symlink.app"
codesign --verify --deep --strict "build/Quick Symlink.app"
echo "Built build/Quick Symlink.app"
