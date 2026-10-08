//
//  FinderSync.swift
//  hard-link-action-extension
//
//  Created by Alexander A. Kropotin on 02/09/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    let quickSymlinkToolbarItemImage = NSImage(named:NSImage.Name(rawValue: "quick-symlink-toolbar-item-image"));
    
    let copyPathAction = CopyPathAction.init();
    let pasteLinkAction = PasteLinkAction.init(fileLinkManager: HardLinkManager.init());
    let createSymlink = CreateLinkAction.init(fileLinkManager: HardLinkManager.init());
    
    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString)
        
        // Set up the directory we are syncing.
        let finderSync = FIFinderSyncController.default();
        
        // Shared group preferences required
        //_ = UserDefaults.init(suiteName: "org.ololx.QuickSymlink")
        
        if let mountedVolumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil,
                                                                      options: .skipHiddenVolumes) {
            finderSync.directoryURLs = Set<URL>(mountedVolumes);
        }
        
        let notificationCenter = NSWorkspace.shared.notificationCenter
        notificationCenter.addObserver(forName: NSWorkspace.didMountNotification, object: nil, queue: .main) {
            (notification) in
            if let volumeURL = notification.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL {
                finderSync.directoryURLs.insert(volumeURL);
            }
        }
    }
    
    // MARK: - Primary Finder Sync protocol methods
    
    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
        NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString)
    }
    
    
    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
    }
    
    // MARK: - Menu and toolbar item support
    
    override var toolbarItemName: String {
        return  NSLocalizedString("HARD_LINK_ACTIONS_EXTENTION_NAME", comment: "");
    }
    
    override var toolbarItemToolTip: String {
        return NSLocalizedString("HARD_LINK_ACTIONS_EXTENTION_TOOL_TIP", comment: "");
    }
    
    override var toolbarItemImage: NSImage {
        return quickSymlinkToolbarItemImage!;
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let quickSymlinkMenu = NSMenu(title: "");
        quickSymlinkMenu.addItem(self.menuItem(
            title: NSLocalizedString("CREATE_LINK_ACTION_NAME", comment: ""),
            action: #selector(createSymlink(_:)),
            symbolName: "link.badge.plus"
        ));
        
        quickSymlinkMenu.addItem(self.menuItem(
            title: NSLocalizedString("COPY_PATH_ACTION_NAME", comment: ""),
            action: #selector(copyPathToClipboard(_:)),
            symbolName: "doc.on.doc"
        ));
        
        let pastleSymlinkFromClipboardMenuItem = self.menuItem(
            title: NSLocalizedString("PASTE_LINK_ACTION_NAME", comment: ""),
            action: #selector(pastleSymlinkFromClipboard(_:)),
            symbolName: "doc.on.clipboard"
        );
        quickSymlinkMenu.addItem(pastleSymlinkFromClipboardMenuItem);
        
        if (NSPasteboard.init(name: NSPasteboard.Name.init(rawValue: "qs")).string(forType: NSPasteboard.PasteboardType.string) ?? "").isEmpty {
            pastleSymlinkFromClipboardMenuItem.isEnabled = false;
        }
        
        if menuKind.rawValue == 3 {
            return quickSymlinkMenu;
        } else {
            let quickSymLinkMainMenu = NSMenu(title: "");
            let quickSymlinkMenuItem = self.menuItem(
                title: NSLocalizedString("HARD_LINK_ACTIONS_EXTENTION_NAME", comment: ""),
                action: nil,
                symbolName: "link.circle"
            );
            quickSymLinkMainMenu.setSubmenu(quickSymlinkMenu, for: quickSymlinkMenuItem);
            quickSymLinkMainMenu.addItem(quickSymlinkMenuItem);
            return quickSymLinkMainMenu;
        }
    }
    
    // Creates a menu item with an SF Symbol icon (macOS 11+; older systems show no icon)
    private func menuItem(title: String, action: Selector?, symbolName: String) -> NSMenuItem {
        let item = NSMenuItem.init(title: title, action: action, keyEquivalent: "")
        if #available(OSX 11.0, *) {
            item.image = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil)
        }
        return item
    }
    
    @IBAction func copyPathToClipboard(_ sender: AnyObject?) {
        self.copyPathAction.execute();
    }
    
    @IBAction func pastleSymlinkFromClipboard(_ sender: AnyObject?) {
        self.pasteLinkAction.execute();
    }
    
    @IBAction func createSymlink(_ sender: AnyObject?) {
        self.createSymlink.execute();
    }
}

