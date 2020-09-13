//
//  ArticlesRealm.swift
//  Domain
//
//  Created by Luu Hong Son on 9/13/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import RealmSwift

public class ArticlesRealm: Object {
    @objc dynamic public var author: String? = nil
    @objc dynamic public var title: String = ""
    @objc dynamic public var desc: String? = nil
    @objc dynamic public var url: String = ""
    @objc dynamic public var urlToImage: String? = nil
    @objc dynamic public var publishedAt: String = ""
    @objc dynamic public var content: String? = nil
    
    public override static func primaryKey() -> String? {
        return "url"
    }
}
