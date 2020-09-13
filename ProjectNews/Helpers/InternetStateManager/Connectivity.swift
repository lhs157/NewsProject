//
//  Connectivity.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/13/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
