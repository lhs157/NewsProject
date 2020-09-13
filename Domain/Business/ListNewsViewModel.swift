//
//  ListNewsViewModel.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

public class ListNewsViewModel {
    public var service: NewsServiceType
    private var disposeBag = DisposeBag()
    
    public var listNews:  Observable<(AnyRealmCollection<ArticlesRealm>, RealmChangeset?)>!
    public var errorsTracker = PublishSubject<DomainError>()
    public var loadingActivity = PublishSubject<Bool>()
    
    public init(service: NewsServiceType) {
        self.service = service
        guard let realm = try? Realm() else {
          return
        }
        listNews = Observable.changeset(from: realm.objects(ArticlesRealm.self))
    }
    
    public func fetchListNews() {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        
        service.fetchNews()
            .trackActivity("loading", with: activityTracker)
            .trackError(errorTracker)
            .asObservable()
            .map { $0.map { $0.toRealmObject() } }
            .bind(to: Realm.rx.add(configuration: Realm.Configuration(), update: .modified, onError: nil))
            .disposed(by: disposeBag)
        
        errorTracker
            .asDomain()
            .bind(to: errorsTracker)
            .disposed(by: disposeBag)
        
        activityTracker
            .status(for: "loading")
            .bind(to: loadingActivity)
            .disposed(by: disposeBag)
        
    }
    
}
