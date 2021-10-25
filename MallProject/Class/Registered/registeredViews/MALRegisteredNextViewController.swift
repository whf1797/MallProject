

//
//  MALRegisteredNextViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/22.
//

import UIKit
/// 注册会员第三步VC
class MALRegisteredNextViewController: MALBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tempTopView)
        tempTopView.loadTitle("注册会员",UIColor.white)
        view.backgroundColor = .white
        view.addSubview(titleShow)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(accountBrankView)
        contentScrollView.addSubview(carNumView)
        contentScrollView.addSubview(realNameiew)
        contentScrollView.addSubview(brankArrdess)
    
        contentScrollView.addSubview(nextBtn)
        
      
        
        
        tempTopView.snp.remakeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
          
        }
        
        titleShow.snp.remakeConstraints { make in
        
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.top.equalTo(tempTopView.snp.bottom).offset(MAL_Value(20))
            
        }
        
        contentScrollView.snp.remakeConstraints { make in
            
            make.top.equalTo(titleShow.snp.bottom)
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomSafeAreaHeight)
            
        }
        
        accountBrankView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        carNumView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(accountBrankView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        realNameiew.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(carNumView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        brankArrdess.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(realNameiew.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
   
       
        nextBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(brankArrdess.snp.bottom).offset(MAL_Value(20))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: MAL_Value(290), height: MAL_Value(36)))
            make.bottom.equalToSuperview().offset(-MAL_Value(28))
        }
        
        
        
    }
    
    private lazy var contentScrollView: UIScrollView = {
         let view = UIScrollView()
         view.showsVerticalScrollIndicator = false
         view.showsHorizontalScrollIndicator = false
         view.backgroundColor = UIColor.white
       
         return view
     }()
    
    
    lazy var tempTopView: SZPNaView = {
        let view = SZPNaView.init(frame: .zero, viewType: .typeOfTitle)
        view.backgroundColor = UIColor.AppColor.main
        view.refreshBackIcon(icon: "nav_icon_with", title: "", cartIcon: "", shareIcon: "")
        view.alpha = 1
        return view
    }()
    
    lazy var titleShow: UIButton = {
        let button = UIButton.init(type: .custom)
        
        button.setImage(MAL_ImageNamed("addwrite"), for: .normal)
      
        button.setTitle("银行卡信息", for: .normal)
        button.setTitleColor(UIColor.AppColor.main, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.szpAppleNormalFont(15)
        button.setContentSpace(MAL_Value(15))
        button.setTitleSpace(MAL_Value(10))
        
        return button
        
    }()
    
    lazy var accountBrankView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "开    户    行：", false,"填写您的开户银行")
        return view
     
    }()
    
    lazy var carNumView : registerTextFile = {
         
        let view = registerTextFile.init(frame: .zero, "银 行  卡 号：", false,"填写您的银行卡号")
        return view
     
    }()
    
    lazy var realNameiew : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "开    户   名：", false,"填写您的开户名")
        return view
     
    }()
    
    ///开户地址
    lazy var brankArrdess : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "开 户  地 址：", false,"填写您的开户地址")
        return view
     
    }()
    
 
    

    
 
    
    lazy var nextBtn: UIButton = {
        
        let view = UIButton.init()
        view.setTitle("下一步", for: .normal)
        
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = UIColor.AppColor.main
        view.radiusView(MAL_Value(36) / 2.0)
        view.addTarget(self, action: #selector(registerNext), for: .touchUpInside)
    
        return view
     
    }()
    
    @objc func registerNext(){
        
        
        let pushVC = MALRegisteredAddressViewController()
        navigationController?.pushViewController(pushVC)
        
        
    }

}

