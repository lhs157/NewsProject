//
//  BaseViewController.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
