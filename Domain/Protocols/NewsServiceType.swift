//
//  NewsServiceType.swift
//  Domain
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Foundation
import RxSwift

public protocol NewsServiceType {
    func fetchNews() -> Single<[Articles]>
}
