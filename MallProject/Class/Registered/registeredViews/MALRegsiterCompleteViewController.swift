//
//  MALRegsiterCompleteViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/24.
//

import UIKit

class MALRegsiterCompleteViewController: MALBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(tempTopView)
        tempTopView.loadTitle("注册会员",UIColor.white)
        view.backgroundColor = .white
        

        view.addSubview(complyView)
        view.addSubview(proTitleLable)
        view.addSubview(nextBtn)
       
        
        tempTopView.snp.remakeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
          
        }
        
        complyView.snp.remakeConstraints { make in
        
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.top.equalTo(tempTopView.snp.bottom).offset(MAL_Value(30))
            make.height.equalTo(MAL_Value(MAL_Value(172)))
            
        }
        
        proTitleLable.snp.remakeConstraints { make in
        
            make.top.equalTo(complyView.snp.bottom).offset(MAL_Value(10))
            make.centerX.equalToSuperview()
            
        }
        
        
        
        nextBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(proTitleLable.snp.bottom).offset(MAL_Value(80))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: MAL_Value(290), height: MAL_Value(36)))
           
        }
  
    }
    
    
    lazy var tempTopView: SZPNaView = {
        let view = SZPNaView.init(frame: .zero, viewType: .typeOfTitle)
        view.backgroundColor = UIColor.AppColor.main
        view.refreshBackIcon(icon: "nav_icon_with", title: "", cartIcon: "", shareIcon: "")
        view.alpha = 1
        return view
    }()
    
    lazy var  complyView: UIImageView = {
        
        let view = UIImageView.init()
        
        view.image =  MAL_ImageNamed("subImage")
        
        return view
        
    }()
    
    lazy var proTitleLable: UILabel = {
        
        let view = UILabel.init()
        view.text = "恭喜!已成功提交"
        view.font = UIFont.szpAppleNormalFont(15)
        view.textColor = UIColor.AppColor.main
        return view
        
    }()
    
    lazy var nextBtn: UIButton = {
        
        let view = UIButton.init()
        view.setTitle("返回首页", for: .normal)
        
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = UIColor.AppColor.main
        view.radiusView(MAL_Value(36) / 2.0)
        view.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
        return view
     
    }()
    
    @objc func backBtn(){
        
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    


}
