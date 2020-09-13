//
//  NewsDetailViewCoordinator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import Domain
import Platform
import RxCocoa

class NewsDetailViewCoordinator: BaseCoordinator {
    var navigationController: BaseNavigationController?
    var selectedNews: Articles!
    
    init(navigationController: BaseNavigationController?, selectedNews: Articles) {
        self.navigationController = navigationController
        self.selectedNews = selectedNews
    }
    
    override func start() {
        let detailNewVC = NewsDetailViewController.instantiate(viewModel: NewsDetailViewModel(selectedNews: selectedNews))
        detailNewVC.backAction.bind(to: backActionBinder).disposed(by: disposeBag)

        
        navigationController?.pushViewController(detailNewVC, animated: true)
        handleStore(coordinator: self)
    }
    
    var backActionBinder: Binder<Void> {
        return Binder(self) { (target, _) in
            target.navigationController?.popViewController(animated: true)
            target.isCompleted?()
        }
    }
}
