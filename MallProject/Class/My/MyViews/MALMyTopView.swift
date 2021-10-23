//
//  MALMyTopView.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/6.
//

import UIKit

class MALMyTopView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.AppColor.searchBgColor
        
        addSubview(backImageView)
        addSubview(hearSilerView)
        addSubview(heardImageView)
        addSubview(idLabel)
        addSubview(vipTimeLable)
        addSubview(vipLeveLabel)
        addSubview(welfareLeveLabel)
        addSubview(moduleView)
        
        
        moduleView.addSubview(centerSlider)
        moduleView.addSubview(shoppingCurrencyLabel)
        moduleView.addSubview(shoppingCurrencyTitle)
        moduleView.addSubview(shoppingCurrencyBtn)
        
        moduleView.addSubview(rewardCurrencyLabel)
        moduleView.addSubview(rewardCurrencyTitle)
        moduleView.addSubview(rewardCurrencyBtn)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.snp.remakeConstraints { make in
           
            make.top.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(225))
            
            
        }
        
        hearSilerView.snp.remakeConstraints { make in
            
            make.top.equalToSuperview().offset(MAL_Value(40))
            make.centerX.equalToSuperview()
            make.size.equalTo(MAL_Value(63))
            
        }
        
        heardImageView.snp.remakeConstraints { make in
            
      
            make.center.equalTo(hearSilerView)
            make.size.equalTo(MAL_Value(56))
            
        }
        
        idLabel.snp.remakeConstraints { make in
            
            make.top.equalTo(heardImageView.snp.bottom).offset(MAL_Value(5))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
         
        }
        vipTimeLable.snp.remakeConstraints { make in
            
            make.top.equalTo(idLabel.snp.bottom).offset(MAL_Value(5))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
         
        }
        
        vipLeveLabel.snp.remakeConstraints { make in
            
            make.left.equalToSuperview().offset(MAL_Value(47))
            make.top.equalTo(vipTimeLable.snp.bottom).offset(MAL_Value(15))
            
        }
        
        welfareLeveLabel.snp.remakeConstraints { make in
            
            make.right.equalToSuperview().offset(-MAL_Value(47))
            make.top.equalTo(vipTimeLable.snp.bottom).offset(MAL_Value(15))
            
        }
        
        moduleView.snp.remakeConstraints { make in
            
            make.bottom.equalToSuperview().offset(-MAL_Value(10))
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.right.equalToSuperview().offset(-MAL_Value(15))
            make.height.equalTo(MAL_Value(83))
        }
        
        centerSlider.snp.remakeConstraints { make in
            
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(MAL_Value(6))
            make.bottom.equalToSuperview().offset(-MAL_Value(6))
            make.centerX.equalToSuperview()
            
        }
        
        shoppingCurrencyLabel.snp.remakeConstraints { make in
        
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview().offset(MAL_Value(15))
          
        }
        
        shoppingCurrencyTitle.snp.remakeConstraints { make in
            
            make.left.equalTo(shoppingCurrencyLabel.snp.left).offset(-MAL_Value(10))
            make.top.equalTo(shoppingCurrencyLabel.snp.bottom).offset(MAL_Value(10))
            
        }
        shoppingCurrencyBtn.snp.remakeConstraints { make in
            
            make.centerY.equalTo(shoppingCurrencyTitle)
            make.left.equalTo(shoppingCurrencyTitle.snp.right).offset(MAL_Value(8))
            make.size.equalTo(CGSize.init(width: MAL_Value(75 / 2.0), height: MAL_Value(15)))
        }
        
        
        
        rewardCurrencyLabel.snp.remakeConstraints { make in
        
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.top.equalToSuperview().offset(MAL_Value(15))
          
        }
        
        rewardCurrencyTitle.snp.remakeConstraints { make in
            
            make.left.equalTo(rewardCurrencyLabel.snp.left).offset(-MAL_Value(10))
            make.top.equalTo(rewardCurrencyLabel.snp.bottom).offset(MAL_Value(10))
            
        }
        rewardCurrencyBtn.snp.remakeConstraints { make in
            
            make.centerY.equalTo(rewardCurrencyTitle)
            make.left.equalTo(rewardCurrencyTitle.snp.right).offset(MAL_Value(8))
            make.size.equalTo(CGSize.init(width: MAL_Value(75 / 2.0), height: MAL_Value(15)))
        }
        
        
        
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backImageView: UIImageView = {
        
        let view = UIImageView.init()
        view.backgroundColor = .white
        view.image = MAL_ImageNamed("myTopBackImage")
        view.contentMode = .scaleAspectFill
        
        return view
    
    }()
    
    lazy var hearSilerView: UIView = {
        
        let view  = UIView.init()
        view.backgroundColor = UIColor.init(hexColor: "#e0b268", alpha: 1)
        view.layer.cornerRadius = MAL_Value(63) / 2.0
        view.layer.masksToBounds = true
        return view
        
    }()
    
    lazy var heardImageView: UIImageView = {
        
        let view = UIImageView.init()
        view.image = MAL_ImageNamed("heardIcon")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = MAL_Value(56) / 2.0
        view.layer.masksToBounds = true
        return view
    
    }()
    
    lazy var idLabel: UILabel = {
        
        let view = UILabel.init()
        view.textColor = .white
        view.font = UIFont.szpAppleNormalFont(15)
        view.textAlignment = .center
        view.text = "ID:12345678"
        return view
        
    }()
    

    
    lazy var vipTimeLable: UILabel = {
        
        let view = UILabel.init()
        view.textColor = .white
        view.font = UIFont.szpAppleNormalFont(12)
        view.textAlignment = .center
        view.text = "会员有效期ID:2022-04-09"
        return view
        
    }()
    
    ///会员等级
    lazy var  vipLeveLabel: UILabel = {
        
        let view = UILabel.init()
        view.textColor = .white
        view.font = UIFont.szpAppleNormalFont(13)
        view.text = "会员级别:钻卡"
        return view
        
    }()
    
    ///福利级别
    lazy var  welfareLeveLabel: UILabel = {
        
        let view = UILabel.init()
        view.textColor = .white
        view.font = UIFont.szpAppleNormalFont(13)
        view.text = "福利级别:经理"
        return view
        
    }()
    ///头部底部模块View
    lazy var moduleView: UIView = {
        
        let view = UIView.init()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = MAL_Value(10)
        view.backgroundColor = .white
        return view
        
    }()
    
    lazy var  centerSlider: UIView = {
        
        let view = UIView.init()
        
        view.backgroundColor = UIColor.init(hexColor: "#c8c8c8")
        
        return view
        
        
    }()
    
    ///购物币
    lazy var shoppingCurrencyLabel: UILabel = {
        
        let view = UILabel.init()
        view.text = MAL_Price("88888")
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        return view
        
    }()
    lazy var shoppingCurrencyTitle: UILabel = {
        
        let view = UILabel.init()
        view.text = "购物币"
        view.font = UIFont.szpAppleNormalFont()
        return view
        
    }()
    
    lazy var shoppingCurrencyBtn: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.backgroundColor = UIColor.AppColor.main
        view.setTitle("明细", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(11)
        view.layer.cornerRadius = MAL_Value(15 / 2.0)
        view.layer.masksToBounds = true
        return view
        
    }()
    
    
    ///奖励币
    lazy var rewardCurrencyLabel: UILabel = {
        
        let view = UILabel.init()
        view.text = MAL_Price("88888")
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        return view
        
    }()
    lazy var rewardCurrencyTitle: UILabel = {
        
        let view = UILabel.init()
        view.text = "购物币"
        view.font = UIFont.szpAppleNormalFont()
        return view
        
    }()
    
    lazy var rewardCurrencyBtn: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.backgroundColor = UIColor.AppColor.main
        view.setTitle("明细", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(11)
        view.layer.cornerRadius = MAL_Value(15 / 2.0)
        view.layer.masksToBounds = true
        return view
        
    }()
    
    
    

}
