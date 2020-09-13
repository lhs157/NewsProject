//
//  News.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

public struct News {
    public let status: String //
    public let totalResults: Int
    public let articles: [Articles]
    
    public init(status: String,
                totalResults: Int,
                articles: [Articles]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

public class Articles {
    @objc dynamic public var author: String?
    @objc dynamic public var title: String
    @objc dynamic public var desc: String?
    @objc dynamic public var url: String
    @objc dynamic public var urlToImage: String?
    @objc dynamic public var publishedAt: String
    @objc dynamic public var content: String?
    
    public init(author: String?,
                title: String,
                description: String?,
                url: String,
                urlToImage: String?,
                publishedAt: String,
                content: String?) {
        self.author = author
        self.title = title
        self.desc = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    func toRealmObject() -> ArticlesRealm {
        let articles = ArticlesRealm()
        articles.author = author
        articles.title = title
        articles.desc = desc
        articles.url = url
        articles.urlToImage = urlToImage
        articles.publishedAt = publishedAt
        articles.content = content
        return articles
    }
}

public struct Source {
    public let id: String?
    public let name: String?
    
    public init(id: String?,
                name: String?) {
        self.id = id
        self.name = name
    }
}
