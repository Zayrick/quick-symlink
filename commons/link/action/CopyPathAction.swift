//
//  CopyPathAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 15/07/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public class CopyPathAction: Action {
    
    private var finderController: FIFinderSyncController;

    public init() {
        self.finderController = FIFinderSyncController.default();
    }
    
    public func execute() {
        //Get all selected path
        guard var target = self.finderController.selectedItemURLs() else {
            NSLog("FinderSync() failed to obtain targeted URLs: %@");
            
            return;
        }
        
        if (target.isEmpty) {
            target.append(self.finderController.targetedURL()!);
        }
        
        LinkSourcePasteboard.remember(target);
    }
}
