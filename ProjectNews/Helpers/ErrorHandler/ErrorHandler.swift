//
//  ErrorHandler.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/11/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class ErrorHandler {
    static var errorBinder: Binder<DomainError> {
        return Binder(UIViewController().topController()) { (_, error) in
            AlertView.shared.presentSimpleAlert(title: "Error", message: error.localizedDescription)
        }
    }
}

extension DomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .other(let error):
            print(error)
            return "Có lỗi xẩy ra, vui lòng thử lại"
        case .lostInternetConnection:
            return "Không có kết nối internet"
        }
    }
}
