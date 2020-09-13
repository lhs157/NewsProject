//
//  DetailNewsViewModel.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import RxSwift
import RxCocoa

public class NewsDetailViewModel {
    private var disposeBag = DisposeBag()
    public var selectedNews: ArticlesRealm!
    public var loadingActivity = PublishSubject<Bool>()
    public var webURL = PublishSubject<String>()
    public init (selectedNews: ArticlesRealm?) {
        self.selectedNews = selectedNews
    }
    
    public func loadWebview() {
        webURL.onNext(selectedNews.url)
    }
}
