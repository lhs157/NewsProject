//
//  BaseCoordinator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import RxSwift

class BaseCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> ())?
    let disposeBag = DisposeBag()
    
    func start() {
        
    }
    
    func handleStore(coordinator: BaseCoordinator) {
        store(coordinator: coordinator)
        coordinator.isCompleted = { [weak self] in
            self?.free(coordinator: coordinator)
        }
    }
}
