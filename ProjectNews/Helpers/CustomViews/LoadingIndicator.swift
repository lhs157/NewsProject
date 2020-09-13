//
//  LoadingIndicator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/11/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import RxCocoa
import SVProgressHUD

class LoadingIndicator {
    static let shared = LoadingIndicator()
    
    func show() {
        SVProgressHUD.show()
    }
    
    func hide() {
        SVProgressHUD.dismiss()
    }
}

extension LoadingIndicator {
    static var defaultLoadingBinder: Binder<Bool> {
        return Binder(LoadingIndicator.shared) { (target, isLoading) in
            if isLoading {
                LoadingIndicator.shared.show()
            } else {
                LoadingIndicator.shared.hide()
            }
        }
    }
}
