//
//  DomainConvertible.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Foundation

public protocol DomainConvertible {
    associatedtype DomainType
    func asDomain() -> DomainType
}
