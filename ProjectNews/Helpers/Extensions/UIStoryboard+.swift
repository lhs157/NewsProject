//
//  UIStoryboard+.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/11/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case home = "Main"
}

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
