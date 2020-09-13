//
//  HomeCoordinator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let coordinator = ListNewsCoordinator(window: window)
        coordinator.start()
    }
}
