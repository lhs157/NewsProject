//
//  NewsObject.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Domain

struct NewsObject: NetworkParsableType {
    init(data: Any) {
        
    }
}

struct NewsModel: Decodable {
    let status: String //
    let totalResults: Int
    let articles: [ArticlesModel]
}

extension NewsModel: DomainConvertible {
    func asDomain() -> News {
        return News(status: status,
                    totalResults: totalResults,
                    articles: articles.asDomain())
    }
}

struct ArticlesModel: Decodable {
    let source: SourceModel
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

extension ArticlesModel: DomainConvertible {
    func asDomain() -> Articles {
        return Articles(source: source.asDomain(),
                        author: author,
                        title: title,
                        description: description,
                        url: url,
                        urlToImage: urlToImage,
                        publishedAt: publishedAt,
                        content: content)
    }
}

struct SourceModel: Decodable {
    let id: String?
    let name: String?
}

extension SourceModel: DomainConvertible {
    func asDomain() -> Source {
        return Source(id: id, name: name)
    }
}


