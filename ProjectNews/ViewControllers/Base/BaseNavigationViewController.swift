//
//  BaseNavigationViewController.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import RxSwift

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
    
}
