//
//  ListNewsViewModel.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import RxSwift
import RxCocoa

public class ListNewsViewModel {
    public var service: NewsServiceType
    private var disposeBag = DisposeBag()
    
    public var listNews = BehaviorSubject<[Articles]>(value: [])
    public var errorsTracker = PublishSubject<DomainError>()
    public var loadingActivity = PublishSubject<Bool>()
    
    public init(service: NewsServiceType) {
        self.service = service
    }
    
    public func fetchListNews() {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        
        service.fetchNews()
            .trackActivity("loading", with: activityTracker)
            .trackError(errorTracker)
            .asObservable()
            .bind(to: loadBinder)
            .disposed(by: disposeBag)
        
        errorTracker
            .asDomain()
            .bind(to: errorBinder)
            .disposed(by: disposeBag)
        
        activityTracker
            .status(for: "loading")
            .bind(to: loadingActivity)
            .disposed(by: disposeBag)
        
    }
    
    private var loadBinder: Binder<[Articles]> {
        return Binder(self) { (target, listNews) in
            target.listNews.onNext(listNews)
        }
    }
    
    private var errorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            target.errorsTracker.onNext(error)
        }
    }
    
}
