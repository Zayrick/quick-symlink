# Quick Symlink

Create symbolic links and hard links right from the Finder context menu, no Terminal required.

[![release](https://img.shields.io/github/v/release/Zayrick/quick-symlink?style=flat&logo=github)](https://github.com/Zayrick/quick-symlink/releases/latest)
[![downloads](https://img.shields.io/github/downloads/Zayrick/quick-symlink/total?style=flat&logo=github)](https://github.com/Zayrick/quick-symlink/releases)
![platform](https://img.shields.io/badge/macOS-12%2B-blue?style=flat&logo=apple)
[![license](https://img.shields.io/github/license/Zayrick/quick-symlink?style=flat)](LICENSE)

Symbolic links are handy for keeping large folders on an external drive while they still appear in their usual place, or for sharing one file between several projects. Quick Symlink makes them a right-click away.

## Features

- **Make Link**: create links to the selected files and folders next to them.
- **Paste Link**: copy files in Finder with ⌘C, then paste links to them in another folder.
- **Move Here and Leave Link**: move the copied files to another folder and leave symbolic links in their original place.
- **Relative or absolute paths** for symbolic links, so links keep working when you move the folder that contains both the link and its target.
- Works on every mounted volume, including external drives.
- Existing files are never overwritten: if the name is taken, the new link is numbered (`name-1`, `name-2`, …).
- Available in English, Russian and Simplified Chinese.

## Installation

1. Download the latest `Quick-Symlink-<version>.dmg` from [Releases](https://github.com/Zayrick/quick-symlink/releases/latest).
2. Open it and drag **Quick Symlink** to **Applications**.
3. Launch Quick Symlink and click **Open Extension Settings…**.
4. Turn on the Quick Symlink Finder extensions:
   - **macOS 15 and later**: in *Login Items & Extensions*, click ⓘ next to Quick Symlink.
   - **macOS 12–14**: in *Extensions › Added extensions*.

   Enable **Symbolic Link Actions**, **Hard Link Actions**, or both.

The app is signed with a Developer ID and notarized by Apple.

## Usage

Right-click files, folders or the background of a Finder window and open the **Symbolic Links** or **Hard Links** submenu. The same menus are available from Finder toolbar buttons, which you can add with *View › Customize Toolbar…*.

| Menu item | What it does |
| --- | --- |
| Make Link | Creates a link to each selected item in the same folder. |
| Paste Link | Creates links to the files copied with ⌘C in the current folder. |
| Move Here and Leave Link | Moves the copied files to the current folder and leaves symbolic links in their place. *(Symbolic Links only)* |
| Use Relative Paths | Toggles relative paths for new symbolic links, on by default. Also available in the app window. *(Symbolic Links only)* |

> Hard links can only point to files on the same volume, and macOS doesn't allow hard links to folders.

## Building

Requires Xcode 26 or later.

```sh
Scripts/build-app.sh                                   # build/Quick Symlink.app, signed to run on this Mac
DEVELOPMENT_TEAM=<team ID> Scripts/build-app.sh        # signed with your Apple Development certificate
Scripts/package-dmg.sh 1.2.3                           # build/Quick-Symlink-1.2.3.dmg
```

Or open `Quick Symlink.xcodeproj` and run the **Quick Symlink** scheme.

```
App/                  the app: settings window
Extensions/
  SymbolicLink/       Finder extension for symbolic links
  HardLink/           Finder extension for hard links
Shared/               code and strings used by the app and both extensions
  Finder/             Finder menu, toolbar item and copied files
  Links/              link creation and relative paths
Tests/                unit tests
Scripts/              build and DMG packaging
```

## Releasing

Releases are published by [GitHub Actions](.github/workflows/release.yml):

1. Update [RELEASE.md](RELEASE.md): the first line is the version (`# 1.2.3`), and everything below it becomes the release notes.
2. Add the same notes to [CHANGELOG.md](CHANGELOG.md).
3. Push to `main`. The workflow builds, signs and notarizes the DMG, then publishes it as release `v1.2.3`.

A release can also be started by hand from the Actions tab. In that case the release notes are the commit titles since the last tag.

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) and the [code of conduct](CODE_OF_CONDUCT.md). Planned work is listed in [TODO.md](TODO.md), and past changes in the [changelog](CHANGELOG.md).

## Acknowledgements

Quick Symlink started as a fork of [quick-symlink](https://github.com/ololx/quick-symlink) by [Alexander A. Kropotin](https://github.com/ololx). Thanks for the original idea and years of work on it.

## License

[MIT](LICENSE)
