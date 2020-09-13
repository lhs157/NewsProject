//
//  LoadingIndicator.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/11/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
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
