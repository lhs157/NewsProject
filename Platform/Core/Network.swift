//
//  Network.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct RequestConvertible: URLRequestConvertible {
    let configuration: NetworkConfiguration
    let endpoint: EndpointConvertible
    
    func asURLRequest() throws -> URLRequest {
        try endpoint.asURLRequest(configuration: configuration)
    }
}

public class Network {
    
    let configuration: NetworkConfiguration
    private var session: Session
    
    init(configuration: NetworkConfiguration, session: Session = Alamofire.Session.default) {
        self.configuration = configuration
        self.session = session
    }

    func request(with endpoint: EndpointConvertible) -> Single<DataRequest> {
        return request(with: RequestConvertible(configuration: configuration, endpoint: endpoint))
    }
    
    func request(with request: RequestConvertible) -> Single<DataRequest> {
        return Single.create { callback -> Disposable in
            callback(.success(self.session.request(request)))
            return Disposables.create()
        }
    }
}
