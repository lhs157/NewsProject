//
//  ActivityTracker.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class ActivityTracker<Activity: Hashable> {
    typealias State = [Activity: Bool]
    private let _activityState = BehaviorRelay<State>(value: [:])
    
    private func startActivity(_ activity: Activity) {
        update(status: true, for: activity)
    }
    
    private func stopActivity(_ activity: Activity) {
        update(status: false, for: activity)
    }
    
    private func update(status: Bool, for activity: Activity) {
        var state = _activityState.value
        if state[activity] != status {
            state[activity] = status
            _activityState.accept(state)
        }
    }
    
    public func status(for activity: Activity) -> Observable<Bool> {
        return _activityState.compactMap { state -> Bool? in
            return state[activity]
        }.distinctUntilChanged().observeOn(MainScheduler.instance)
    }
}

// MARK: - ActivityTracker + PrimitiveSequence
//Single
extension ActivityTracker {
    fileprivate func trackActivity<E>(_ activity: Activity, from source: Single<E>) -> Single<E> {
        return source.do(afterSuccess: { _ in
            self.stopActivity(activity)
        }, afterError: { _ in
            self.stopActivity(activity)
        }, onSubscribe: {
            self.startActivity(activity)
        }, onDispose: {
            self.stopActivity(activity)
        })
    }
}

// MARK: - Operators

extension PrimitiveSequenceType where Trait == SingleTrait {
    func trackActivity<Activity: Hashable>(_ activity: Activity, with tracker: ActivityTracker<Activity>) -> Single<Element> {
        return tracker.trackActivity(activity, from: self.primitiveSequence)
    }
}
