//
//  NewsService.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import RxSwift
import Domain

public struct NewsService {
    let network: Network
    
    public init(network: Network) {
        self.network = network
    }
}

extension NewsService: NewsServiceType {
    public func fetchNews() -> Single<[Articles]> {
        return network
            .request(with: Router.news)
            .responseDecodable(of: [ArticlesModel].self, keyPath: "articles")
            .mapToDomain()
    }
}
