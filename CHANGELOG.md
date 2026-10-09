# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.11.0] - 2026-10-09

### Added

- Simplified Chinese localization.
- `Open Extension Settings…` button that opens where the Finder extensions are enabled (Login Items & Extensions on macOS 15 and later).
- Number new links (`name-1`, `name-2`, …) instead of overwriting existing files.
- Signed and notarized DMG installer, published by GitHub Actions.

### Changed

- Rewrite the application and the Finder extensions in Swift and SwiftUI.
- Require macOS 12 or later.
- Rename the menus to `Symbolic Links` and `Hard Links` with the `Make Link`, `Paste Link`, `Move Here and Leave Link` and `Use Relative Paths` items.
- `Paste Link` and `Move Here and Leave Link` use the files copied in Finder with ⌘C.
- `Move Here and Leave Link` moves the item back if the link can't be created.
- Use SF Symbols for menu and toolbar icons, following Light and Dark Mode.
- New application icon and settings window.

### Removed

- The `Copy path from here` menu item.
- The separate British English localization.

## [0.10.6] - 2022-02-16

### Fixed

- Fix the menu items duplicate problem - the menu items appends (+ 1) for every menu showing.

## [0.10.5] - 2022-02-10

### Changed

- Delete public modifiers for methods in public extensions.
- Delete @obj method for authorizing.
- Refactor defaults.

## [0.10.4] - 2021-10-10

### Fixed

- Fix  incorrect link location after creation.

## [0.10.3] - 2021-10-07

### Added

- Add the checkbox item on the contextual menu of the `soft link extention` to switch on/off the relative path use to create a symbolic link.

## [0.10.2] - 2021-10-05

### Changed

- Change the menu item names for hard link actions - replace `alias` to `hard link`.

## [0.10.1] - 2021-10-05

### Fixed

- Fix the localization bug - only `Russian` localization in for all `system languages`.

## [0.10.0] - 2021-09-18

### Added

- Add the checkbox button on the application view to switch on/off the relative path use to create a symbolic link.
- Implement the strategy for create new symlink with relative or absolute path.

## [0.9.0] - 2021-09-17

### Changed

- Change the extention boubdle name from `quick-symlink-extention to `symlink actions`.
- Change the module name `quick-symlink-extention to `soft-link-actions-name`.

## [0.8.1] - 2021-09-13

### Fixed

- Fix a bug that led to fatal error: `Can't remove last element from an empty collection`.

### Added

- Added the ability to create links from the `Finder` menu without selected objects.

## [0.8.0] - 2021-09-02

### Added

- Develop additional `Finder extension`  which allows to create a `hard links` for selected folders and files via contextual menu.

### Changed

- Change build os version to 10.10.

### Fixed

- Fix soft link replace with function.

## [0.7.0] - 2021-08-22

### Added

- Add new classes `Path` for working with path's and creating relative path from specified directory.
- Add unit-tests cases for the `Path` class.

### Changed

- Change soft link creation using relative instead absolute path.

## [0.6.0] - 2021-08-02

### Changed

- Change the activity property of some menu items according to the rule:
	- if no object was copied, then the menu items "Paste link to here" an "Move it here and replace with a link"  are not active.
	- if at least one object was not copied, then the menu items  "Paste link to here" an "Move it here and replace with a link" are inactive.

### Added

- Add cleaning clipboard after inserting links.

## [0.5.0] - 2021-08-02

### Added

- Add the new menu item for creating symlink in a parent directory (parent for target objects).

## [0.4.1] - 2021-07-15

### Changed

- Implement the  `Command` pattern for the `Quick Symlink` actions.

### Added

- Add the new menu item for replacing selected folders and files with symlinks.

## [0.4.0] - 2021-07-15

### Added

- Add the extension localization for English and Russian languages.

## [0.0.4] - 2021-05-28

### Added

- The application icons.

### Changed

- The toolbar icons.

## [0.0.3] - 2021-05-25

### Added

- The toolbar icon.

### Changed

- The language version from Swift 5.0 to Swift 4.0.
- The project version from xcode 12.x to xCode 9.2.

## [0.0.2] - 2021-05-10

### Added

- Add the `Finder toolbar menu`  which allows to:
  - automate the symbolic links creation.
  - create symbolic links for the selected files or folders.
  - save symbolic links to the selected directory.

## [0.0.1] - 2021-05-08

### Added

- The `Finder extension`  which allows to:
  - automate the symbolic links creation.
  - create symbolic links for the selected files or folders.
  - save symbolic links to the selected directory.