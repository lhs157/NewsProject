//
//  ViewUtils.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit

class ViewUtils {
    class func safeAreaInsets() -> UIEdgeInsets {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window!.safeAreaInsets
    }
}

struct ViewConstants {
    static let headerContentHeight = CGFloat(44)
}
