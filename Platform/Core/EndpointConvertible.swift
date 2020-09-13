//
//  EndpointConvertible.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Alamofire

protocol EndpointConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    
    func asURLRequest(configuration: NetworkConfiguration) throws -> URLRequest
}

extension EndpointConvertible {
    
    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "Authorization": ""]
    }
    
    func asURLRequest(configuration: NetworkConfiguration) throws -> URLRequest {
        let url = configuration.baseURL
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 10
        urlRequest.allHTTPHeaderFields = headers
        if method == .get {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        printURLPretty(urlRequest)
        return urlRequest
    }
    
    private func printURLPretty(_ urlRequest: URLRequest?) {
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        print("Parameters: \(String(describing: parameters))")
        if let jsonBody = urlRequest?.httpBody {
            print("JSON: \(String(describing: String(data: jsonBody, encoding: .utf8)))")
        }
        print("URL: \(String(describing: urlRequest?.url?.absoluteString))")
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    }
}
