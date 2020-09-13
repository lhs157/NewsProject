//
//  ErrorTracker.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class ErrorTracker {
    private let _subject = PublishSubject<Error>()
    
    func asDriver() -> Driver<Error> {
        return _subject.asDriver(onErrorDriveWith: Driver.empty())
    }
    
    func asObservable() -> Observable<Error> {
        return _subject.asObservable().observeOn(MainScheduler.instance)
    }
    
    private func onError(_ error: Error) {
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}

extension ErrorTracker: DomainConvertible {
    public func asDomain() -> Observable<DomainError> {
        return self.asObservable().map { $0.asDomainError() }
    }
}

// MARK: - ErrorTracker + PrimitiveSequence
//Single
extension ErrorTracker {
    fileprivate func trackError<E>(from source: Single<E>) -> Single<E> {
        return source.do(onError: onError)
    }
}

// MARK: - Operators

extension PrimitiveSequenceType where Trait == SingleTrait {
    func trackError(_ tracker: ErrorTracker) -> Single<Element> {
        return tracker.trackError(from: self.primitiveSequence)
    }
}
