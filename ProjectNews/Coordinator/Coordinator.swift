//
//  Coordinator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
