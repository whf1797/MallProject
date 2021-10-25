//
//  MALMyViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit
//我的VC
class MALMyViewController: MALBaseViewController {
    
    private enum KMyItemType: Int {
        case typeOfModifyData,          //修改资料
             typeOfModifyPassword,      //修改密码
             typeOfReceivingAddress,    //管理地址
             typeOfRegistrationOrder,   //我的注册订单
             typeOfProductOrder,        //我的产品订单
             typeOfRegisteredMember,    //注册会员
             typeOfRevokeMember,        //撤销会员
             typeOfWithdrawal           //申请提现
            
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        view.removeSubviews()
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(topView)
        contentScrollView.addSubview(modifyData)
        contentScrollView.addSubview(modifyPassword)
        contentScrollView.addSubview(receivingAddress)
        contentScrollView.addSubview(registrationOrder)
        contentScrollView.addSubview(productOrder)
        contentScrollView.addSubview(registeredMember)
        contentScrollView.addSubview(revokeMember)
        contentScrollView.addSubview(withdrawal )
        
      
    }
    
    override func viewDidLayoutSubviews() {
       
        super.viewDidLayoutSubviews()
        
        contentScrollView.snp.remakeConstraints { make in
            
            make.top.equalTo(-kStatusBarHeight)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kTabBarHeight)
            
        }
        
        topView.snp.remakeConstraints { make in
    
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(MAL_Value(276))
            
        }
        
        modifyData.snp.remakeConstraints { make in
            
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        modifyPassword.snp.remakeConstraints { make in
            
            make.top.equalTo(modifyData.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        receivingAddress.snp.remakeConstraints { make in
            
            make.top.equalTo(modifyPassword.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        registrationOrder.snp.remakeConstraints { make in
            
            make.top.equalTo(receivingAddress.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        productOrder.snp.remakeConstraints { make in
            
            make.top.equalTo(registrationOrder.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        registeredMember.snp.remakeConstraints { make in
            
            make.top.equalTo(productOrder.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        revokeMember.snp.remakeConstraints { make in
            
            make.top.equalTo(registeredMember.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
        withdrawal.snp.remakeConstraints { make in
            
            make.top.equalTo(revokeMember.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
            
        }
        
    }
    
    private lazy var contentScrollView: UIScrollView = {
         let view = UIScrollView()
         view.showsVerticalScrollIndicator = false
         view.showsHorizontalScrollIndicator = false
         view.backgroundColor = UIColor.AppColor.searchBgColor
         view.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(p_loadData))
         return view
     }()
    
    lazy var topView: MALMyTopView = {
        
        let view  = MALMyTopView.init(frame: .zero)
        return view
        
    }()
    ///修改资料
    lazy var modifyData: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "修改资料")
        item.showContent(text: "修改资料", leftIcon: "modifyData")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfModifyData.rawValue
        return item
    }()
    
    ///修改密码
    lazy var modifyPassword: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "修改密码")
        item.showContent(text: "修改密码", leftIcon: "modifyPassword")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfModifyPassword.rawValue
        return item
    }()
    
    ///管理收货地址
    lazy var receivingAddress: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "管理收货地址")
        item.showContent(text: "管理收货地址", leftIcon: "receivingAddress")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfReceivingAddress.rawValue
        return item
    }()
    
    //我的注册订单
    lazy var registrationOrder: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "我的注册订单")
        item.showContent(text: "我的注册订单", leftIcon: "registrationOrder")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfRegistrationOrder.rawValue
        return item
    }()
    
    ///我的订单产品
    lazy var productOrder: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "我的产品订单")
        item.showContent(text: "我的产品订单", leftIcon: "productOrder")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfProductOrder.rawValue
        return item
    }()
    
    ///注册会员
    lazy var registeredMember: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "注册会员")
        item.showContent(text: "注册会员", leftIcon: "registeredMember")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfRegisteredMember.rawValue
        return item
    }()
    
    ///撤销会员
    lazy var revokeMember: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "撤销会员")
        item.showContent(text: "撤销会员", leftIcon: "revokeMember")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfRevokeMember.rawValue
        return item
    }()
    
    ///申请提现
    lazy var withdrawal: MALMyItem = {
        let item = MALMyItem(frame: .zero, title: "申请提现")
        item.showContent(text: "申请提现", leftIcon: "withdrawal")
        item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(p_tapAction(_:))))
        item.tag = KMyItemType.typeOfWithdrawal.rawValue
        return item
    }()
    
    
    @objc func p_loadData(){
        
        
        contentScrollView.mj_header.endRefreshing()
        
    }
    
    @objc private func p_tapAction(_ sender:UITapGestureRecognizer) {
        
        
      // let loginView =  MALLoginViewController()
        
       // self.navigationController?.pushViewController(loginView)
        
        
        let alertView =  MALRegisterAgreeView.init(frame: UIScreen.main.bounds)
       
        kWindow?.addSubview(alertView)
        
        
        
        
        
  
        
        
    }
    
}

class MALMyItem: UIView {

    init(frame: CGRect, title:String, hideIcon:Bool = false) {
        super.init(frame: frame)

        backgroundColor = UIColor.white
        addSubview(leftIconImage)
        addSubview(nameLabel)
        addSubview(contentLabel)
        addSubview(detailIcon)
        addSubview(line)
        addSubview(heardIcon)

        nameLabel.text = title
        detailIcon.isHidden = hideIcon
        heardIcon.isHidden = true
        
    }


    /// 显示内容
    /// - Parameters:
    ///   - text: 内容
    ///   - hideLine: 是否隐藏下划线
    public func showContent(text: String,hideContent: Bool = true, hideLine: Bool = false,leftIcon:String) {
        contentLabel.text = text
        contentLabel.isHidden = hideContent
        line.isHidden = hideLine
        leftIconImage.image = MAL_ImageNamed(leftIcon)
    }
    
    public func showHearder() {
      
        contentLabel.isHidden = true
        heardIcon.isHidden = false
        
        
     }
    
    public func hideIcon(hideIcon:Bool){
        
        detailIcon.isHidden = hideIcon
        layoutSubviews()
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let offx = MAL_Value(15)
        
        leftIconImage.frame = CGRect(x: offx*2, y: 0, width: MAL_Value(17), height: MAL_Value(17))
        leftIconImage.centerY = height * 0.5
 
        nameLabel.frame = CGRect(x: leftIconImage.right + offx , y: 0, width: MAL_Value(130), height: height)
        let iconWH = MAL_Value(15)
        
     
        
        detailIcon.frame = CGRect(x: width - offx - iconWH, y: 0, width: MAL_Value(7), height: MAL_Value(11))
        detailIcon.centerY = height * 0.5

        let contentW = MAL_Value(175)
        contentLabel.frame = CGRect(x: nameLabel.right +  MAL_Value(5), y: 0, width: contentW, height: height)
        
        heardIcon.frame = CGRect(x: detailIcon.left - MAL_Value(52) , y: 5, width: MAL_Value(48), height: MAL_Value(48))
        
        line.frame = CGRect(x: offx, y: height - 1, width: width - offx * 2, height: 1)

        
    }
    
    lazy var leftIconImage: UIImageView = {
        
        let view = UIImageView.init()
        
        return view
        
    }()
    

    lazy var nameLabel: UILabel = {
        let view = UILabel.init(text: "昵称".local)
        view.font = UIFont.szpHelveticaFont(14)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        return view
    }()
    
    lazy var heardIcon: UIImageView = {
        
        let view = UIImageView.init()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = MAL_Value(24)
        return view

    }()
    
    lazy var contentLabel: UILabel = {
        let view = UILabel.init(text: "昵称".local)
        view.font = UIFont.szpAppleNormalFont(10)
        view.textColor = UIColor.AppColor.titleColorLight
        view.textAlignment = .right
        return view
    }()

    lazy var detailIcon: UIImageView = {
        let view = UIImageView()
        view.image = MAL_ImageNamed("arrow_right")
        return view
    }()
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColor.cellLineColor
        return view
    }()

}
