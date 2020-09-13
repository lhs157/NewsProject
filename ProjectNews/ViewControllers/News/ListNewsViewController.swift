//
//  ListNewsViewController.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import RxRealmDataSources

class ListNewsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListNewsViewModel!
    var showDetailAction = PublishRelay<ArticlesRealm>()

    public static func instantiate(viewModel: ListNewsViewModel) -> ListNewsViewController {
        let vc = UIViewController().instantiateViewController(fromStoryboard: .home, ofType: ListNewsViewController.self)
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addObservers()
        viewModel.fetchListNews()
    }
    
    private func setupView() {
        tableView.register(UINib(nibName: String(describing: NewsCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NewsCell.self))
        tableView.cr.addHeadRefresh { [weak self] in
            self?.viewModel.fetchListNews()
        }
    }
    
    private func addObservers() {
        
        let dataSource = RxTableViewRealmDataSource<ArticlesRealm>(cellIdentifier:
        String(describing: NewsCell.self), cellType: NewsCell.self) { cell, _, articles in
            cell.configCell(articles)
        }
        
        viewModel.listNews
            .bind(to: tableView.rx.realmChanges(dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.realmModelSelected(ArticlesRealm.self)
        .bind(to: showDetailAction)
        .disposed(by: disposeBag)
                
        viewModel.errorsTracker.bind(to: errorBinder).disposed(by: disposeBag)
        viewModel.loadingActivity.bind(to: loadingHUDBinder).disposed(by: disposeBag)

    }
    
    private var errorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            AlertView.shared.presentSimpleAlert(title: "Error", message: error.localizedDescription)
            target.tableView.cr.endHeaderRefresh()
        }
    }
    
    private var loadingHUDBinder: Binder<Bool> {
        return Binder(self) { (target, isLoading) in
            if isLoading {
                LoadingIndicator.shared.show()
            } else {
                LoadingIndicator.shared.hide()
                target.tableView.cr.endHeaderRefresh()
            }
        }
    }
}
