//
//  DomainError.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

public enum DomainError: Error {
    case other(error: Error)
    case lostInternetConnection
}

//MARK: - Mapping

public protocol DomainErrorConvertible {
    func asDomainError() -> DomainError
}

extension DomainError: DomainErrorConvertible {
    public func asDomainError() -> DomainError {
        return self
    }
}

extension Error {
    func asDomainError() -> DomainError {
        (self as? DomainErrorConvertible)?.asDomainError() ?? .other(error: self)
    }
}
