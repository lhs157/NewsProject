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
    public var hasCache = PublishSubject<Bool>()
    public var archivedURL: URL!
    public var isHasCache = false
    
    public var webURL = PublishSubject<String>()
    public init (selectedNews: ArticlesRealm?) {
        self.selectedNews = selectedNews
        archivedURL = URL(string: "https://google.com.vn")
        guard let titleNews = selectedNews?.title else {
            return
        }
        archivedURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(titleNews).appendingPathExtension("webarchive")
    }
    
    public func loadWebview() {
        webURL.onNext(selectedNews.url)
    }
    
    public func checkHasCache() {
        guard FileManager.default.fileExists(atPath: archivedURL.path) else {
            hasCache.onNext(false)
            return
        }
        isHasCache = true
        hasCache.onNext(true)
    }
}
