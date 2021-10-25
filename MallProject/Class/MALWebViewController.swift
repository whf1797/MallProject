//
//  MALWebViewController.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/4/21.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit

import WebKit


class MALWebViewController: MALBaseViewController {
    

  
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        showBackItem(false)

        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavigationBarHeight)
            make.left.width.equalToSuperview()
//            make.bottom.equalToSuperview()
        }
        contentView.webTitleBlock = { (webTitle) in
            self.title = webTitle
        }
    }

    func showWebUrl(_ weburl:String) {
        if !weburl.isEmpty {
            contentView.loadWebUrl(weburl, true)
        }
    }

    lazy var contentView: SZPWebView = {
        let view = SZPWebView()
        return view
    }()

}


class SZPWebView: UIView, WKNavigationDelegate {
    
    var permissions:Bool = true
    
    var getHeight:((_ height:Double) -> Void)?

    private let kWebProgressKey = "estimatedProgress"
    private let kWebTitleKey = "title"
    private let progressColorBg = UIColor.lightGray
    private let progressColorTint = UIColor.AppColor.main

    var webTitleBlock: ((_ webtitle:String) -> Void)?

    private var isShowProgressView = false {
        didSet {
            progressView.isHidden = !isShowProgressView
        }
    }

   private var webUrl: String = ""

    /// 加载html格式的内容
   private var htmlString: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(progressView)
        addSubview(webContent)
        progressView.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(2)
        }

        webContent.snp.remakeConstraints { (make) in
            make.top.equalTo(isShowProgressView ? 2 : 0).priority(.high)
            make.left.right.equalToSuperview()
//            make.height.equalTo((Device().orientation == Device.Orientation.portrait ? self.webViewHeightPortrait : self.webViewHeightLandscape) ).priorityHigh()
//            let contentH = CGFloat(webContent.heightConstraint()?.constant ?? 0)
//            make.height.equalTo(contentH).priority(.high)
            make.bottom.equalToSuperview()
        }

        webContent.addObserver(self, forKeyPath: kWebProgressKey, options: .new, context: nil)
        webContent.addObserver(self, forKeyPath: kWebTitleKey, options: .new, context: nil)

        webContent.scrollView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(p_refreshRequest))
    }


    /// 加载 url
    public func loadWebUrl(_ url:String, _ isShowProgress:Bool = false) {

        isShowProgressView = isShowProgress
        webUrl = url
      
        if !webUrl.isEmpty {

            let webRequest = URLRequest.init(url: URL.init(string: webUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0)
            webContent.load(webRequest)
        }
    }
    
    public func loadHTMLString(_ content: String?) {
        guard let content = content else { return }
        webContent.scrollView.mj_header?.removeFromSuperview()
        isShowProgressView = false
        htmlString = content
        
     

        let headerString : String = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0'/><style>img{max-width:100%}</style></header>"
        
        webContent.loadHTMLString(headerString + content, baseURL: nil)
        
        /**   - 接入html字符串 显示

         1、在字符串前加入一段html控制页面和图片缩放的语句
            let headerString : String = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>"
            webView.loadHTMLString(headerString + content), baseURL: nil)

         */
        // 2、在didFinish navigation代理方法中获取高度
         func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

             webView.evaluateJavaScript("document.body.scrollHeight") { (result, _) in
                 // 页面高度
                 let height = result as? Double
                 self.webContent.heightConstraint()?.constant = CGFloat(height ?? 0)
                
                
             }
         }
        
    }


    /// web内部 是否可以滑动
    public var isCanscroll: Bool = true {
        didSet {
            webContent.scrollView.isScrollEnabled = isCanscroll
        }
    }
    /// 隐藏刷新功能
    public var hideRefresh: Bool = false {
        didSet {
            webContent.scrollView.bounces = !hideRefresh
            if hideRefresh {
                webContent.scrollView.mj_header?.removeFromSuperview()
            } else {
                webContent.scrollView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(p_refreshRequest))
            }
        }
    }
    
    @objc private func p_refreshRequest() {
        if webUrl.isEmpty {
            loadHTMLString(htmlString)
        } else {
            loadWebUrl(webUrl, isShowProgressView)
        }
    }

    private func p_endRefresh() {

        if (webContent.scrollView.mj_header?.isRefreshing) != nil {
            webContent.scrollView.mj_header?.endRefreshing()
        }
    }

    // MARK: Delegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        if isShowProgressView {
            progressView.isHidden = false
            progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.5)
            bringSubviewToFront(progressView)
        }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

        p_endRefresh()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        webView.evaluateJavaScript("document.body.scrollHeight") {[weak self] (result, _) in
            // 页面高度
           
            if(self?.permissions == true){
                
                let height = result as? Double
                self?.webContent.heightConstraint()?.constant = CGFloat(height ?? 0)
                
            }
            
            guard let block = self?.getHeight else {
               return
            }
            block(result as? Double ?? 0)
            
          
             
            
        }
        p_endRefresh()
    }


    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if (keyPath?.contains(kWebProgressKey))! {
            let progress = Float(webContent.estimatedProgress)
            progressView.progress = progress
            if progress == 1 {

                UIView.animateKeyframes(withDuration: 0.25, delay: 0.3, options: .autoreverse) { [self] in

                    progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.4)
                } completion: { [self] (_) in
                    progressView.isHidden = true
                    p_endRefresh()
                }
            }
        } else if (keyPath?.contains(kWebTitleKey)) != nil {

            guard let block = webTitleBlock else { return }
            let title = webContent.title!
            block(title)

        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    deinit {
        if isShowProgressView {
            webContent.removeObserver(self, forKeyPath: kWebProgressKey)
        }
        webContent.removeObserver(self, forKeyPath: kWebTitleKey)
    }

    // MARK: lazy
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   public lazy var webContent: WKWebView = {

        let config = WKWebViewConfiguration.init()
        let view = WKWebView.init(frame: CGRect.zero, configuration: config)
        view.navigationDelegate = self
        view.scrollView.showsVerticalScrollIndicator = false
        view.scrollView.showsHorizontalScrollIndicator = false
        return view
    }()
    private lazy var progressView: UIProgressView = {

        let view = UIProgressView.init(frame: CGRect.zero)
        view.backgroundColor = progressColorBg
        view.progressTintColor = progressColorTint
        view.isHidden = true
        return view
    }()
}
