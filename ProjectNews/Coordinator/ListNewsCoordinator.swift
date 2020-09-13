//
//  ListNewsCoordinator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import Domain
import Platform
import RxCocoa
import RxSwift

class ListNewsCoordinator: BaseCoordinator {
    let window: UIWindow
    var navigationController: BaseNavigationController?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = BaseNavigationController()
    }
    
        override func start() {
            let network = AppNetwork()
            let listNewsVC = ListNewsViewController.instantiate(viewModel: ListNewsViewModel(service: NewsService(network: network)))
            navigationController = BaseNavigationController(rootViewController: listNewsVC)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            listNewsVC.showDetailAction.bind(to: showNewsDetailBinder).disposed(by: disposeBag)
            handleStore(coordinator: self)
    }
    
    private var showNewsDetailBinder: Binder<ArticlesRealm> {
        return Binder(self) { (target, article) in
            target.showNewsDetailScreen(article)
        }
    }
    
    private func showNewsDetailScreen(_ article: ArticlesRealm) {
        let coordinator = NewsDetailViewCoordinator(navigationController: navigationController, selectedNews: article)
        coordinator.start()
    }
}
