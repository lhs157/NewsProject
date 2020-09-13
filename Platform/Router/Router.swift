//
//  Router.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Alamofire

enum Router: EndpointConvertible {

    case news
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .news:
            return "top-headlines"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .news:
            return ["country": "us", "apiKey": API_KEY]
        }
    }
}
