//
//  MALRegistereMembersVController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/22.
//

import UIKit
/// 注册会员第一步VC
class MALRegistereMembersVController: MALBaseViewController {
    
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
        contentScrollView.addSubview(memNumView)
        contentScrollView.addSubview(memLeveView)
        contentScrollView.addSubview(userNameiew)
        contentScrollView.addSubview(userNickNameiew)
        contentScrollView.addSubview(idCarView)
        
        contentScrollView.addSubview(phoneView)
        contentScrollView.addSubview(refereesView)
        contentScrollView.addSubview(personView)
        contentScrollView.addSubview(locationView)
        contentScrollView.addSubview(serviceCenternView)
        contentScrollView.addSubview(leve1passwordView)
        contentScrollView.addSubview(sureleve1passwordView)
        
        contentScrollView.addSubview(leve2passwordView)
        contentScrollView.addSubview(sureleve2passwordView)
        
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
        
        memNumView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        memLeveView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(memNumView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        userNameiew.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(memLeveView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        userNickNameiew.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(userNameiew.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        idCarView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(userNickNameiew.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        phoneView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(idCarView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        
        refereesView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        personView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(refereesView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        locationView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(personView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        serviceCenternView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(locationView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        leve1passwordView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(serviceCenternView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        sureleve1passwordView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(leve1passwordView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        leve2passwordView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(sureleve1passwordView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        sureleve2passwordView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(leve2passwordView.snp.bottom).offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(28))
            
        }
        
        nextBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(sureleve2passwordView.snp.bottom).offset(MAL_Value(20))
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
      
        button.setTitle("基本信息", for: .normal)
        button.setTitleColor(UIColor.AppColor.main, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.szpAppleNormalFont(15)
        button.setContentSpace(MAL_Value(15))
        button.setTitleSpace(MAL_Value(10))
        
        return button
        
    }()
    
    lazy var memNumView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "会   员    编  号：", false,"此处不可编辑",false)
        return view
     
    }()
    
    lazy var memLeveView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "会   员    级  别：", false,"VIP",false)
        return view
     
    }()
    
    lazy var userNameiew : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "姓               名：", true,"填写您的真实姓名")
        return view
     
    }()
    
    ///昵称
    lazy var userNickNameiew : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "昵               称：", true,"填写您的昵称")
        return view
     
    }()
    
    ///身份证
    lazy var idCarView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "身       份     证：", true,"填写您的身份证号")
        return view
     
    }()
    
    ///手机号码
    lazy var phoneView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "手   机   号  码：", true,"请填写您的手机号码")
        return view
     
    }()
    
    ///推荐人编号
    lazy var refereesView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "推 荐 人 编 号：", true,"填写您的推荐人编号")
        return view
     
    }()
    
    ///接点人编号
    lazy var personView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "接 点 人 编 号：", true,"填写您的接点人编号")
        return view
     
    }()
    
    ///所在位置
    lazy var locationView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "所  在   位  置：", true,"请选择您的位置")
        return view
     
    }()
    
    ///服务中心
    lazy var serviceCenternView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "服  务   中  心：", true,"填写您的服务中心")
        return view
    }()
    
    ///一级密码
    lazy var leve1passwordView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "一  级   密   码：", false,"填写您的一级密码")
        return view
    }()
    ///确认级密码
    lazy var sureleve1passwordView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "一 级密码确认：", false,"再次填写您的一级密码")
        return view
    }()
    
    ///二级密码
    lazy var leve2passwordView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "二   级   密  码：", false,"填写您的二级密码")
        return view
    }()
    
    ///确认二级密码
    lazy var sureleve2passwordView : registerTextFile = {
        
        let view = registerTextFile.init(frame: .zero, "二级密码确认：", false,"再次填写您的二级密码")
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
        
        
        let pushVC = MALRegisteredNextViewController()
        navigationController?.pushViewController(pushVC)
        
        
    }
    

}

class registerTextFile: UIView{
    
    
    init(frame: CGRect, _ title:String, _ isMust: Bool = true, _ placeholder:String, _ isCanEditor:Bool = true) {
        
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(titleIcon)
        addSubview(titleLabel)
        addSubview(inputTextFild)
        addSubview(sliderView)
        
        inputTextFild.placeholder = placeholder
        inputTextFild.isUserInteractionEnabled = isCanEditor
        titleLabel.text = title
        
        if(isMust == true){
            
            titleIcon.isHidden = false
            titleIcon.text = "*"
           
        }else{
            
            titleIcon.isHidden = true
            titleIcon.text = ""
        
        }
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        titleIcon.snp.remakeConstraints { make in
        
            make.left.equalToSuperview().offset( MAL_Value(15))
            make.centerY.equalToSuperview()
            make.width.equalTo(MAL_Value(10))
            
            
        }
        
        titleLabel.snp.remakeConstraints { make in
            
            make.left.equalTo(titleIcon.snp.right).offset(titleIcon.isHidden == true ? 0 : MAL_Value(5))
            make.centerY.equalTo(titleIcon.snp.centerY)
            make.width.equalTo(MAL_Value(100))
            
            
        }
        
        inputTextFild.snp.remakeConstraints { make in
            
            make.left.equalTo(titleLabel.snp.right).offset(MAL_Value(2))
            make.right.equalToSuperview().offset(MAL_Value(-15))
            make.centerY.equalToSuperview()
            
        }
        
        sliderView.snp.remakeConstraints { make in
            
            make.left.equalTo(inputTextFild)
            make.right.equalToSuperview()
            make.bottom.equalTo(inputTextFild)
            make.height.equalTo(1)
          
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleIcon: UILabel = {
        
        let view = UILabel.init()
        view.text = "*"
        view.textColor = UIColor.init(hexColor: "#df0000")
        view.backgroundColor = .white
        return view
        
    }()
    
    lazy var titleLabel: UILabel = {
        
        let view = UILabel.init()
        view.font = UIFont.szpAppleNormalFont(13)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        view.backgroundColor = .white
        
        return view
     
    }()
    
    
    lazy var inputTextFild : UITextField = {
       
        let view = UITextField.init()
        view.font = UIFont.szpAppleNormalFont(13)
        return view
    
    }()
    
    lazy var sliderView: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = UIColor.init(hexColor: "#c8c8c8")
       
        return view
   
    }()
    
    
    
    
    
}
