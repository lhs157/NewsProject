//
//  Sequence+.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//


import Domain

extension Array: DomainConvertible where Element: DomainConvertible {
    public func asDomain() -> Array<Element.DomainType> {
        return map { $0.asDomain() }
    }
}
