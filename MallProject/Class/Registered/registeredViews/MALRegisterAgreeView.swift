//
//  MALRegisterAgreeView.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/22.
//

import UIKit
import WebKit
///注册协议
class MALRegisterAgreeView: UIView {
    
  
    var pathUrl: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.AppColor.alertBackgroundColor
        addSubview(backView)
        backView.addSubview(tipLabel)
        backView.addSubview(myWKWebView)
        backView.addSubview(sureProvedBtn)
        backView.addSubview(nextBtn)
        
      

        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.snp.remakeConstraints { make in
            
            make.width.equalTo( MAL_Value(335))
            make.centerX.equalToSuperview()
            make.top.equalTo(MAL_Value(130))
         
        }
        
        tipLabel.snp.remakeConstraints { make in
        
            make.top.equalToSuperview().offset(MAL_Value(20))
            make.centerX.equalToSuperview()
            
        }
        
        myWKWebView.snp.remakeConstraints { make in
            make.top.equalTo(tipLabel.snp.bottom).offset(MAL_Value(10))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: MAL_Value(575 / 2), height: MAL_Value(211)))
         
        }
        
        sureProvedBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(myWKWebView.snp.bottom).offset(MAL_Value(20))
            make.centerX.equalToSuperview()
       
        }
        
        nextBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(sureProvedBtn.snp.bottom).offset(MAL_Value(10))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: MAL_Value(290), height: MAL_Value(36)))
            make.bottom.equalToSuperview().offset(-MAL_Value(28))
        }
        

    }
    
    lazy var myWKWebView: WKWebView = {
        
     
        let configuration = WKWebViewConfiguration()
        // 创建设置对象
        let preference = WKPreferences()
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = true
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences = preference
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        configuration.allowsInlineMediaPlayback = true
        let view = WKWebView.init(frame: .zero, configuration: configuration)
        view.uiDelegate = self
        view.navigationDelegate = self
        view.backgroundColor = .clear
        setShadow(view: view, width: 1,UIColor.AppColor.main, sColor: UIColor.AppColor.main, opacity: 0, radius: MAL_Value(10))
        return view
        
        
    }()
    
    lazy var backView: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = .white
        view.radiusView(MAL_Value(8))
        return view
        
        
    }()
    
    lazy var tipLabel: UILabel = {
        let view = UILabel.init(text: "注册协议".local)
        view.font = UIFont.szpAppleNormalFont(19)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        view.textAlignment = .center
        return view
    }()
    
    
    lazy var sureProvedBtn: UIButton = {
        
        let button = UIButton.init(type: .custom)
    
        button.isUserInteractionEnabled = true
        button.setImage(MAL_ImageNamed("radio_n"), for: .normal)
        button.setImage(MAL_ImageNamed("radio_s"), for: .selected)
      
        button.setTitle("是否同意", for: .normal)
        button.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        button.backgroundColor = UIColor.white
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.szpAppleNormalFont(16)
        button.setContentSpace(MAL_Value(15))
        button.setTitleSpace(MAL_Value(10))
        button.addTarget(self, action: #selector(selectItem(_:)), for: .touchUpInside)
        
        return button

    }()
    
    @objc func selectItem(_ sender:UIButton){
        
        
        sender.isSelected = !sender.isSelected
        
        
    }
    
    lazy var nextBtn: UIButton = {
        
        let view = UIButton.init()
        view.setTitle("下一步", for: .normal)
        
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = UIColor.AppColor.main
        view.radiusView(MAL_Value(36) / 2.0)
        view.addTarget(self, action: #selector(nextRegistBtn(_ :)), for: .touchUpInside)
        return view
     
    }()
    
    @objc func nextRegistBtn(_ sender: UIButton){
        
        removeFromSuperview()
        let pushVC = MALRegistereMembersVController()
        let currentVC = UINavigationController.getTopViewController()
        currentVC?.navigationController?.pushViewController(pushVC, animated: true)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        removeFromSuperview()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension MALRegisterAgreeView:WKUIDelegate, WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        
      
        
        MALAutoProgressHUD.showHud("加载中···")


    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {

            MALAutoProgressHUD.hideHud()
        
        })
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        var request: URLRequest? = nil
        if let url = URL(string: pathUrl) {
            request = URLRequest(url: url)
        }
        if let request = request {
            myWKWebView.load(request)
        }
        myWKWebView.reload()

    }
    
    
}
