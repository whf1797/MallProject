//
//  MALRegsiterdCorrespondingVC.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/22.
//

import UIKit
/// 注册会员第五步VC
class MALRegsiterdCorrespondingVC: MALBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tempTopView)
        tempTopView.loadTitle("注册会员",UIColor.white)
        view.backgroundColor = .white
        view.addSubview(titleShow)
        
        view.addSubview(goodsView)
        
        view.addSubview(nextBtn)
        
     
 
        tempTopView.snp.remakeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
          
        }
        
        titleShow.snp.remakeConstraints { make in
        
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.top.equalTo(tempTopView.snp.bottom).offset(MAL_Value(20))
            
        }
        
        goodsView.snp.remakeConstraints { make in
        
            make.left.right.equalToSuperview()
            make.top.equalTo(titleShow.snp.bottom)
            make.height.equalTo(MAL_Value(120))
            
            
            
        }
        
        nextBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(goodsView.snp.bottom).offset(MAL_Value(20))
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
    
    lazy var titleShow: UIButton = {
        let button = UIButton.init(type: .custom)
        
        button.setImage(MAL_ImageNamed("addwrite"), for: .normal)
      
        button.setTitle("对应产品", for: .normal)
        button.setTitleColor(UIColor.AppColor.main, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.szpAppleNormalFont(15)
        button.setContentSpace(MAL_Value(15))
        button.setTitleSpace(MAL_Value(10))
        
        return button
        
    }()
    
    
    lazy var goodsView: registerGoodsView = {
        
        let view =  registerGoodsView.init(frame:.zero)
        return view
    }()
  
    lazy var nextBtn: UIButton = {
        
        let view = UIButton.init()
        view.setTitle("下一步", for: .normal)
        
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = UIColor.AppColor.main
        view.radiusView(MAL_Value(36) / 2.0)
    
        return view
     
    }()
    

}
class registerGoodsView: UIView  {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(goodImageView)
        addSubview(goodTitle)
        addSubview(currentPriceLabel)
        addSubview(countLabel)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        goodImageView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.top.equalToSuperview().offset(MAL_Value(10))
            make.size.equalTo(CGSize.init(width: MAL_Value(100), height: MAL_Value(100)))
            
        }
        
        goodTitle.snp.remakeConstraints { make in
            
            
            make.left.equalTo(goodImageView.snp.right).offset(MAL_Value(15))
            make.top.equalTo(goodImageView)
            make.right.equalToSuperview().offset(-MAL_Value(15))
        }
        
        currentPriceLabel.snp.remakeConstraints { make in
        
            make.top.equalTo(goodTitle.snp.bottom).offset(MAL_Value(10))
            make.left.equalTo(goodTitle)
            
            
            
        }
        
        countLabel.snp.remakeConstraints { make in
        
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(MAL_Value(10))
            make.left.equalTo(goodTitle)
            
            
            
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var  goodImageView:UIImageView = {
        
        let view = UIImageView.init()
        return view
    
    }()
    
    lazy var goodTitle: UILabel = {
        
        let view = UILabel.init()
        view.text = "产品产品产品"
        return view
        
    }()
    
     lazy var countLabel: UILabel = {
        let view = UILabel.init(text: "0")
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor.AppColor.titleColorLight
        view.textAlignment = .center
        view.backgroundColor = UIColor.init(hexString: "f2f2f2")
        view.text = String(format: "数量:%d",1)
       
        return view
    }()
     lazy var currentPriceLabel: UILabel = {
        let view = UILabel.init(text: MAL_Price("998"))
        view.font = UIFont.szpHelveticaFont(16)
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        view.text = String(format: "金额:%@", MAL_Price("998"))
       
        return view
    }()
    
    
    
}


