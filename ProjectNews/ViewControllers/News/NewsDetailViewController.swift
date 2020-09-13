//
//  NewsDetailViewController.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa
import Domain
import CRRefresh

class NewsDetailViewController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    var webView: WKWebView!
    var configuration = WKWebViewConfiguration()
    var viewModel: NewsDetailViewModel!
    var backAction = PublishRelay<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        setupView()
        addObserver()
        viewModel.loadWebview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LoadingIndicator.shared.hide()
    }
    
    private func setupView() {
        webView.scrollView.cr.beginHeaderRefresh()
        webView.scrollView.cr.addHeadRefresh { [weak self] in
            self?.viewModel.loadWebview()
        }
    }

    public static func instantiate(viewModel: NewsDetailViewModel) -> NewsDetailViewController {
        let vc = UIViewController().instantiateViewController(fromStoryboard: .home, ofType: NewsDetailViewController.self)
        vc.viewModel = viewModel
        return vc
    }
    
}

// MARK: -- Observer

extension NewsDetailViewController {
    func addObserver() {
        backButton.rx.tap.bind(to: backAction).disposed(by: disposeBag)
        viewModel.webURL.bind(to: loadWebURL).disposed(by: disposeBag)
    }
    
    private var loadWebURL: Binder<String> {
        return Binder(self) { (target, webURL) in
            if let url = URL(string: webURL) {
                let urlRequest = URLRequest(url: url)
                target.webView.load(urlRequest)
            }
        }
    }
}


// MARK: -- Config
extension NewsDetailViewController {
    func configureWebView() {
        
        // Config datasource
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        if webView != nil {
            webView.removeFromSuperview()
        }
        configuration.preferences = preferences
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        // Config layout
        webView.snp.makeConstraints { (make) -> Void in
            let safeAreaInset = ViewUtils.safeAreaInsets()
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: safeAreaInset.top + ViewConstants.headerContentHeight, left: safeAreaInset.left, bottom: safeAreaInset.bottom, right: safeAreaInset.right))
        }
    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoadingIndicator.shared.show()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        LoadingIndicator.shared.hide()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingIndicator.shared.hide()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.perform(#selector(hideLoadingControl), with: self, afterDelay: 1.0)
    }
    
    @objc func hideLoadingControl() {
        LoadingIndicator.shared.hide()
        webView.scrollView.cr.endHeaderRefresh()
    }
}

