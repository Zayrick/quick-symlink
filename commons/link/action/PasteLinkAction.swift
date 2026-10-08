//
//  PasteSymlinkAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 15/07/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public class PasteLinkAction: Action {
    
    private var finderController: FIFinderSyncController;
    
    private var fileLinkManager: FileLinkManager;
    
    public init(fileLinkManager: FileLinkManager!) {
        self.finderController = FIFinderSyncController.default();
        self.fileLinkManager = fileLinkManager;
    }
    
    public func execute() {
        //Get selected folder path
        guard let target = self.finderController.targetedURL() else {
            NSLog("FinderSync() failed to obtain targeted URL: %@");
            
            return;
        }
        
        for pathUrl in LinkSourcePasteboard.take() {
            let targetPath = self.fileLinkManager.getTargetPath(pathUrl, to: target);
            self.fileLinkManager.linkWith(of: pathUrl, with: targetPath);
        }
    }
}
