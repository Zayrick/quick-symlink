# 0.11.0

Quick Symlink has been rebuilt from the ground up for current versions of macOS.

### Added

- Simplified Chinese localization.
- **Open Extension Settings…** button that takes you straight to where the Finder extensions are turned on (Login Items & Extensions on macOS 15 and later).
- New links never overwrite existing files: if the name is taken, they are numbered (`name-1`, `name-2`, …).
- Signed and notarized DMG installer.

### Changed

- Requires macOS 12 or later.
- New Finder menus: **Symbolic Links** and **Hard Links**, each with **Make Link** and **Paste Link**. Symbolic Links also offers **Move Here and Leave Link** and **Use Relative Paths**.
- **Paste Link** and **Move Here and Leave Link** now use the files you copied in Finder with ⌘C.
- **Move Here and Leave Link** puts the item back if the link can't be created.
- Menu and toolbar icons use SF Symbols and follow Light and Dark Mode.
- New app icon and a simpler settings window.

### Removed

- The **Copy path from here** menu item. Copy files in Finder with ⌘C instead.
- The separate British English localization.
