//
//  LinkFinderSync.swift
//  Quick Symlink
//

import Cocoa
import FinderSync

/// Finder context menu and toolbar item shared by both extensions.
/// Each extension subclasses it and only chooses the kind of link it creates.
class LinkFinderSync: FIFinderSync {

    var kind: LinkKind {
        fatalError("Subclasses must override kind")
    }

    override init() {
        super.init()

        // Show the menu everywhere: on all mounted volumes, including ones mounted later
        let controller = FIFinderSyncController.default()
        let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: .skipHiddenVolumes) ?? []
        controller.directoryURLs = Set(volumes)

        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.didMountNotification, object: nil, queue: .main) { notification in
            if let volume = notification.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL {
                controller.directoryURLs.insert(volume)
            }
        }
    }

    // MARK: - Toolbar item

    override var toolbarItemName: String {
        kind.title
    }

    override var toolbarItemToolTip: String {
        kind.toolTip
    }

    override var toolbarItemImage: NSImage {
        NSImage(systemSymbolName: kind.symbolName, accessibilityDescription: nil)!
    }

    // MARK: - Menu

    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "")
        let hasCopiedFiles = !CopiedFiles.isEmpty

        menu.addItem(menuItem(
            NSLocalizedString("Make Link", comment: "Create a link to each selected item next to it"),
            action: #selector(makeLink(_:)),
            symbolName: "link.badge.plus"
        ))
        menu.addItem(menuItem(
            NSLocalizedString("Paste Link", comment: "Create links to the files copied with Command-C in the current folder"),
            action: #selector(pasteLink(_:)),
            symbolName: "doc.on.clipboard",
            isEnabled: hasCopiedFiles
        ))

        if kind == .symbolic {
            menu.addItem(menuItem(
                NSLocalizedString("Move Here and Leave Link", comment: "Move the copied files into the current folder and leave links in their original location"),
                action: #selector(moveHereAndLeaveLink(_:)),
                symbolName: "arrow.right.doc.on.clipboard",
                isEnabled: hasCopiedFiles
            ))

            // Shows its state with the icon rather than a checkmark: a checkmark would make the
            // menu reserve a checkmark column, leaving an empty gap in front of every item
            menu.addItem(.separator())
            menu.addItem(menuItem(
                NSLocalizedString("Use Relative Paths", comment: "Toggle: create symbolic links with relative instead of absolute paths"),
                action: #selector(toggleRelativePaths(_:)),
                symbolName: Settings.useRelativePaths ? "checkmark.circle" : "circle"
            ))
        }

        if menuKind == .toolbarItemMenu {
            return menu
        }

        // In context menus, group everything in a submenu
        let rootItem = menuItem(kind.title, action: nil, symbolName: kind.symbolName)
        rootItem.submenu = menu
        let rootMenu = NSMenu(title: "")
        rootMenu.addItem(rootItem)
        return rootMenu
    }

    private func menuItem(_ title: String, action: Selector?, symbolName: String, isEnabled: Bool = true) -> NSMenuItem {
        let item = NSMenuItem(title: title, action: action, keyEquivalent: "")
        item.image = menuImage(symbolName)
        item.isEnabled = isEnabled
        return item
    }

    /// Finder receives menu images from the extension without their template flag, so it draws
    /// them as-is (black, even in Dark Mode). Bake in the label color of the current appearance instead.
    private func menuImage(_ symbolName: String) -> NSImage? {
        guard let symbol = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil) else { return nil }

        var color = NSColor.black
        (NSApp?.effectiveAppearance ?? NSAppearance.currentDrawing()).performAsCurrentDrawingAppearance {
            color = NSColor(cgColor: NSColor.labelColor.cgColor) ?? .black
        }

        let image = symbol.withSymbolConfiguration(NSImage.SymbolConfiguration(paletteColors: [color]))
        image?.isTemplate = false
        return image
    }

    // MARK: - Actions

    @IBAction func makeLink(_ sender: AnyObject?) {
        let controller = FIFinderSyncController.default()
        var items = controller.selectedItemURLs() ?? []
        if items.isEmpty, let folder = controller.targetedURL() {
            items = [folder]
        }

        perform(on: items) { maker, item in
            try maker.makeLink(to: item, in: item.deletingLastPathComponent())
        }
    }

    @IBAction func pasteLink(_ sender: AnyObject?) {
        guard let folder = FIFinderSyncController.default().targetedURL() else { return }

        perform(on: CopiedFiles.read()) { maker, item in
            try maker.makeLink(to: item, in: folder)
        }
    }

    @IBAction func moveHereAndLeaveLink(_ sender: AnyObject?) {
        guard let folder = FIFinderSyncController.default().targetedURL() else { return }

        perform(on: CopiedFiles.read()) { maker, item in
            try maker.moveAndLeaveLink(item, to: folder)
        }
    }

    @IBAction func toggleRelativePaths(_ sender: AnyObject?) {
        Settings.useRelativePaths.toggle()
    }

    /// Runs `action` for every item, so one failure does not stop the others.
    private func perform(on items: [URL], _ action: (LinkMaker, URL) throws -> Void) {
        let maker = LinkMaker(kind: kind, useRelativePaths: Settings.useRelativePaths)
        for item in items {
            do {
                try action(maker, item)
            } catch {
                NSLog("Quick Symlink failed for %@: %@", item.path, error.localizedDescription)
            }
        }
    }
}

private extension LinkKind {

    var title: String {
        switch self {
        case .symbolic: return NSLocalizedString("Symbolic Links", comment: "Finder context menu: submenu title for symbolic link actions")
        case .hard: return NSLocalizedString("Hard Links", comment: "Finder context menu: submenu title for hard link actions")
        }
    }

    var toolTip: String {
        switch self {
        case .symbolic: return NSLocalizedString("Create symbolic links to the selected items", comment: "Finder toolbar item tooltip")
        case .hard: return NSLocalizedString("Create hard links to the selected items", comment: "Finder toolbar item tooltip")
        }
    }

    var symbolName: String {
        switch self {
        case .symbolic: return "link"
        case .hard: return "link.circle"
        }
    }
}
