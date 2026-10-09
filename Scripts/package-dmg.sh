#!/bin/sh
# Builds a Release "Quick Symlink.app" and packages it into build/Quick-Symlink-<version>.dmg.
#
#   Scripts/package-dmg.sh 1.2.3 [build-number]
#
# Optional environment:
#   SIGN_IDENTITY   codesign identity, e.g. "Developer ID Application: Name (TEAMID)"; ad-hoc when empty
#   NOTARY_APPLE_ID, NOTARY_PASSWORD, NOTARY_TEAM_ID
#                   notarize and staple the DMG (requires a Developer ID identity)
set -eu

version="${1:?usage: $0 <version> [build-number]}"
build_number="${2:-1}"
identity="${SIGN_IDENTITY:--}"

cd "$(dirname "$0")/.."
derived_data="$(mktemp -d)"
staging="$(mktemp -d)"
lsregister=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister
built_app="$derived_data/Build/Products/Release/Quick Symlink.app"
cleanup() {
    # Xcode registers every built app with Launch Services, which leaves duplicates in System Settings
    "$lsregister" -u "$built_app" 2>/dev/null || true
    rm -rf "$derived_data" "$staging"
}
trap cleanup EXIT

echo "Building Quick Symlink $version ($build_number)"
if ! xcodebuild -project "Quick Symlink.xcodeproj" -scheme "Quick Symlink" -configuration Release \
    -derivedDataPath "$derived_data" \
    MARKETING_VERSION="$version" CURRENT_PROJECT_VERSION="$build_number" \
    build > "$derived_data/build.log" 2>&1; then
    tail -n 50 "$derived_data/build.log"
    exit 1
fi

app="$staging/Quick Symlink.app"
ditto "$built_app" "$app"

# Xcode signs ad-hoc; re-sign inside-out with the real identity, keeping the entitlements Xcode applied
# minus get-task-allow, which notarization rejects
resign() {
    entitlements="$staging/entitlements.plist"
    codesign -d --entitlements "$entitlements" --xml "$1" 2>/dev/null
    /usr/libexec/PlistBuddy -c "Delete :com.apple.security.get-task-allow" "$entitlements" 2>/dev/null || true
    codesign --force --timestamp --options runtime --entitlements "$entitlements" --sign "$identity" "$1"
    rm -f "$entitlements"
}
if [ "$identity" != "-" ]; then
    echo "Signing with $identity"
    for appex in "$app"/Contents/PlugIns/*.appex; do
        resign "$appex"
    done
    resign "$app"
fi
codesign --verify --deep --strict "$app"

dmg="build/Quick-Symlink-$version.dmg"
mkdir -p build
rm -f "$dmg"

# dmgbuild lays out the installer window without scripting Finder, so it also works on CI
venv=build/.dmgbuild-venv
if [ ! -x "$venv/bin/dmgbuild" ]; then
    python3 -m venv "$venv"
    "$venv/bin/pip" install --quiet dmgbuild==1.6.7
fi
mkdir "$staging/background"
swift Scripts/dmg/background.swift "$staging/background"
"$venv/bin/dmgbuild" -s Scripts/dmg/settings.py \
    -D app="$app" -D background="$staging/background/background.png" \
    "Quick Symlink $version" "$dmg" > /dev/null

if [ "$identity" != "-" ]; then
    codesign --force --timestamp --sign "$identity" "$dmg"
fi

if [ -n "${NOTARY_APPLE_ID:-}" ] && [ -n "${NOTARY_PASSWORD:-}" ] && [ -n "${NOTARY_TEAM_ID:-}" ]; then
    case "$identity" in
        "Developer ID Application"*) ;;
        *) echo "Notarization requires a Developer ID Application identity, got: $identity" >&2; exit 1 ;;
    esac
    echo "Notarizing $dmg"
    xcrun notarytool submit "$dmg" --apple-id "$NOTARY_APPLE_ID" --password "$NOTARY_PASSWORD" \
        --team-id "$NOTARY_TEAM_ID" --wait
    xcrun stapler staple "$dmg"
fi

echo "Built $dmg"
