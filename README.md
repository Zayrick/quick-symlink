<div align="right">
  <a href="https://github.com/ololx/quick-symlink/stargazers" target="_blank">
		<img src="https://img.shields.io/github/stars/ololx/quick-symlink?style=social" alt="Stars earned"/>
	</a>
  <img src="https://img.shields.io/github/downloads/ololx/quick-symlink/total?style=social" alt="downloads"/>
  	<a href="https://github.com/ololx/quick-symlink/discussions" target="_blank">
		<img src="https://img.shields.io/github/discussions/ololx/quick-symlink?label=welcome%20to%20discussions&logo=github&style=social" alt="discutions"/>
	</a>
</div>

# Quick Symlink

The Quick Symlink is a `Finder extension`  which provides a `contextual menu item` for the symbolic links (and other links) creation on macOS. 

[![tag](https://img.shields.io/github/v/tag/ololx/quick-symlink?style=flat&include_prereleases&logo=github)](https://github.com/ololx/quick-symlink/tags) [![release](https://img.shields.io/github/v/release/ololx/quick-symlink?style=flat&include_prereleases&logo=github)](https://github.com/ololx/quick-symlink/releases)

[![osslifecycle](https://img.shields.io/osslifecycle/ololx/quick-symlink?style=flat)](OSSMETADATA) [![last_commit](https://img.shields.io/github/last-commit/ololx/quick-symlink?style=flat&logo=github)](https://github.com/ololx/quick-symlink/commits) [![release_date](https://img.shields.io/github/release-date/ololx/quick-symlink?style=flat&logo=github)](https://github.com/ololx/quick-symlink/releases)

[![licence](https://img.shields.io/github/license/ololx/quick-symlink?style=flat)](LICENCE) [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?style=flat)](CODE_OF_CONDUCT.md) [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink?ref=badge_shield)

![repo_size](https://img.shields.io/github/repo-size/ololx/quick-symlink?style=flat&logo=github) ![languages_code_size](https://img.shields.io/github/languages/code-size/ololx/quick-symlink?style=flat&logo=github) ![languages_count](https://img.shields.io/github/languages/count/ololx/quick-symlink?style=flat&logo=github) ![languages_top](https://img.shields.io/github/languages/top/ololx/quick-symlink?style=flat&logo=github)

![platform](https://img.shields.io/badge/platform-OS_X_10.10+-important?style=flat)

## 📇 Table of Contents

- [About](#-about-)
- [Demo](#-demo-)
- [Features](#-feature-)
- [Getting Started](#-getting-started-)
- [Built With](#-built-with-)
- [Contributing](#-contributing-)
- [Code of Conduct](#-code-of-conduct-)
- [Versioning](#-versioning-)
- [Authors](#-authors-)
- [Licensing](#-licensing-)

##  📖 About

The Quick Symlink is a Finder Extension  which allows to create symbolic links of selected folders or files. It could be called by right-clicking on selected folders or files and selecting `Quick Symlink` from the contextual menu. **It is a remaster of the other project - `create-symlink`; for more details see https://github.com/ololx/create-symlink.**

### Motivation

For me the symbolic links is a useful feature of macOS. They can be especially useful when it's needed to store the `Documents` folder on a hard drive or SD card, but on the ssd to create a just link to this folder.
Of course, creating symbolic links via the terminal is very easy and convenient. But this does not negate the fact that it could be even easier and more comfortable through interaction with the GUI.

## 📸 Demo

This GIF demonstrates how the `Quick Symlink` allows quite simple to select files or folders and paste symlink in the current directory.

<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-2.gif?raw=true" width="100%"/>

This GIF demonstrates how the `Quick Symlink` allows quite simple to copy files or folders and paste symlink somewhere.

<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-1.gif?raw=true" width="100%"/>

This GIF demonstrates how the `Quick Symlink` allows quite simple to copy files or folders, paste them somewhere, and replace them with symlinks.

<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-replace-with-link.gif?raw=true" width="100%"/>

<details close>
    <summary>These GIFs demonstrate the `Quick Symlink` localization.</summary>
	<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-localization-1.gif?raw=true" width="100%"/>
	<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-localization-2.gif?raw=true" width="100%"/>
</details>

## 🎚 Features

- Create a symbolic links in a several clicks via the context menu instead of the terminal promt:
  - Select files or folders and create symlinks for them.
  - Copy files or folders and paste symlinks somewhere.
  - Copy files or folders, paste them somewhere, and replace them with symlinks.

- Create a hard links in a several clicks via the context menu instead of the terminal promt:
  - Select files or folders and create hard links for them.
  - Copy files or folders and paste hard links somewhere.

### To Do

- For more information on an upcoming development, please read the [todo](TODO.md) list.

### Changelog

- For more information on releases, features and changes, please read the [changelog](CHANGELOG.md) notes.

## 🚦 Getting Started

These instructions allow to get a copy of this project and run it on a local machine.

### Prerequisites

Before using it, make sure that follows software are installed on the local machine:

- **[OS X 10.10+](https://www.apple.com/ru/macos/what-is/)** - the operating system under which the extention is executing.

If any of the listed programs is not installed, then it can be installed by instruction as described below.

1. #### macOS 12+
    - Install macOS 12+ by [this](https://support.apple.com/ht201372) instruction.

### Installing

In order to install it is quite simple to:

1. Download executable file from releases (or compile it from the sources).
2. Go to the directory where you download this tool (optionally):

   - via Finder.
   - via Terminal prompt.

   ```bash
   cd /{path to parent dir with this tool}/
   ```

3. Launch the tool in macOS (optionally):

   - via double-click on `Quick Symlink.app`.
   - via Terminal prompt.

   ```bash
   open "Quick Symlink.app"
   ```

4. Click "Open Finder Extension Settings…" in the app window (or open `System Settings > General > Login Items & Extensions > Finder`) and enable the follows extensions:
  4.1. `Symbolic Link Actions` - for the symlink actions.
  4.2. `Hard Link Actions` - for the hard link actions.

**Otherwise, it's possible to install and remove the extention using the actual extension bundled into the app.**

1. To install and approve the extension, run this:

```bash
pluginkit -a "Quick Symlink.app/Contents/PlugIns/SymbolicLinkExtension.appex/"
pluginkit -a "Quick Symlink.app/Contents/PlugIns/HardLinkExtension.appex/"
```

2. To remove it, run this:

```bash
pluginkit -r "Quick Symlink.app/Contents/PlugIns/SymbolicLinkExtension.appex/"
pluginkit -r "Quick Symlink.app/Contents/PlugIns/HardLinkExtension.appex/"
```

5. [OPTIONAL] Check/Uncheck the checkbox on the Application window "Use relative paths for symbolic links" to use the relative path instead absolute path for the creating symlinks. **By default it's enabled**

<img src="https://github.com/ololx/quick-symlink/blob/assets/use-relative.png?raw=true" width="30%"/>

### Building

Open `Quick Symlink.xcodeproj` in Xcode 16+ and run the `Quick Symlink` scheme, or build a Release app into `build/` from the Terminal:

```bash
Scripts/build-app.sh                                 # signed to run on this Mac only
DEVELOPMENT_TEAM=<your team ID> Scripts/build-app.sh # signed with your Apple Development certificate
```

The project is organized as follows:

```
App/                  the app: settings window
Extensions/
  SymbolicLink/       Finder extension for symbolic links
  HardLink/           Finder extension for hard links
Shared/               code and strings used by the app and both extensions
  Finder/             Finder menu, toolbar item and copied files
  Links/              link creation and relative paths
Tests/                unit tests
```

### Downloading

For the downloading executable file or sources to a local machine, just use the follows link and choose a required release:

```http
https://github.com/ololx/quick-symlink/releases/
```

### Cloning

For the cloning this repository to a local machine, just use the follows link:

```http
https://github.com/ololx/quick-symlink.git
```

### Using

This tool allows to:
<details close>
    <summary>Create symlinks in the current directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Symbolic Links --> Make Link`.<br/>
</details>

<details close>
    <summary>Create symlinks in another directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Copy them with `⌘C`.<br/>
3. Go to a destination folder.<br/>
4. Call the contextual menu by right-clicking on the folder.<br/>
5. Select menu item `Symbolic Links --> Paste Link`.<br/>
</details>

<details close>
    <summary>Replace objects with symbolic links</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Copy them with `⌘C`.<br/>
3. Go to a destination folder.<br/>
4. Call the contextual menu by right-clicking on the folder.<br/>
5. Select menu item `Symbolic Links --> Move Here and Leave Link`.<br/>
</details>

<details close>
    <summary>Create hard links in the current directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Hard Links --> Make Link`.<br/>
</details>

<details close>
    <summary>Create symlinks in another directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Copy them with `⌘C`.<br/>
3. Go to a destination folder.<br/>
4. Call the contextual menu by right-clicking on the folder.<br/>
5. Select menu item `Hard Links --> Paste Link`.<br/>
</details>

## 🛠 Built With

- **[Xcode](https://developer.apple.com/xcode/)** - the IDE for the `Finder Sync Extension` development.

## 🎉 Contributing

If you want to contribute this project - you are welcome and have fun.
Please visit the [contributing](CONTRIBUTING.md) section for details on this code of conduct, and the process for submitting pull requests.

## 📝 Code of Conduct

In order to ensure that all is welcoming, please review and abide by the [code of conduct](CODE_OF_CONDUCT.md).

## 🗒 Versioning

For the versioning is used [Semantic Versioning](http://semver.org/). For the versions available, see the [changelog](CHANGELOG.md) or the tags on this repository.

## ©️ Authors

* **Alexander A. Kropotin** - *Initial work* - [ololx](https://github.com/ololx).

## 🔏 Licensing

This project is licensed under the MIT license - see the [lisence](LICENSE) document for details.


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink?ref=badge_large)
