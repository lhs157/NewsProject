//
//  AppNetwork.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Domain

public class AppNetwork: Network {
    
    public init() {
        super.init(configuration: NetworkConfiguration(baseURL: baseURL))
    }
}
