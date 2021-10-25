//
//  MALLoginViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/18.
//

import UIKit

///登录页面
class MALLoginViewController: MALBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(hexColor: "#f2f2f2")
        view.addSubview(backImageView)
        view.addSubview(loginItemView)
        loginItemView.addSubview(memberBtnView)
        loginItemView.addSubview(reportBtnView)
        loginItemView.addSubview(phoneField)
        loginItemView.addSubview(passwordField)
        loginItemView.addSubview(codeField)
        loginItemView.addSubview(codeImageView)
        loginItemView.addSubview(getcodeLable)
        loginItemView.addSubview(forgetPasswordBtn)
        loginItemView.addSubview(loginBtn)
        
        loginItemView.addSubview(phoneBottomSlider)
        loginItemView.addSubview(passwordBottomSlider)
        loginItemView.addSubview(codeBottomSlider)
        view.addSubview(promLable)

    }
    
    override func viewDidLayoutSubviews() {
    
        super.viewDidLayoutSubviews()
        
        
        backImageView.snp.remakeConstraints { make in
            
            make.top.equalToSuperview().offset(-kStatusBarHeight)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(MAL_Value(225))
         
        }
        loginItemView.snp.remakeConstraints { make in
            
            make.left.equalToSuperview().offset(MAL_Value(20))
            make.width.equalTo(kScreenWidth - MAL_Value(20) * 2)
            make.top.equalTo(backImageView.snp.bottom).offset(-MAL_Value(61))
            make.height.equalTo(MAL_Value(335))
         
        }
        
      
        
        memberBtnView.snp.remakeConstraints { make in
        
            make.left.top.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(MAL_Value(52))
            
        }
        
        reportBtnView.snp.remakeConstraints { make in
        
            make.right.top.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(MAL_Value(52))
            
        }
        
        phoneField.snp.remakeConstraints { make in
            
            make.top.equalTo(reportBtnView.snp.bottom).offset(MAL_Value(20))
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.right.equalToSuperview().offset(-MAL_Value(15))
            make.height.equalTo(MAL_Value(45))
            
        }
        phoneBottomSlider.snp.remakeConstraints { make in
            
            make.left.right.bottom.equalTo(phoneField)
            make.height.equalTo(1)
        }
        
        passwordField.snp.remakeConstraints { make in
            
            make.top.equalTo(phoneField.snp.bottom).offset(MAL_Value(10))
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.right.equalToSuperview().offset(-MAL_Value(15))
            make.height.equalTo(MAL_Value(45))
            
        }
        
        passwordBottomSlider.snp.remakeConstraints { make in
            
            make.left.right.bottom.equalTo(passwordField)
            make.height.equalTo(1)
        }
        
        codeField.snp.remakeConstraints { make in
            
            make.top.equalTo(passwordField.snp.bottom).offset(MAL_Value(10))
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.right.equalToSuperview().offset(-MAL_Value(15))
            make.height.equalTo(MAL_Value(45))
            
        }
        
        codeBottomSlider.snp.remakeConstraints { make in
            
            make.left.right.bottom.equalTo(codeField)
            make.height.equalTo(1)
        }
        
        getcodeLable.snp.remakeConstraints { make in
        
            make.right.equalTo(codeField.snp.right).offset(MAL_Value(-15))
            make.bottom.equalTo(codeField.snp.bottom).offset(-MAL_Value(12))
            make.size.equalTo(CGSize.init(width: MAL_Value(90), height: MAL_Value(35)))
            
        }
        
        codeImageView.snp.remakeConstraints { make in
        
            make.right.equalTo(codeField.snp.right).offset(MAL_Value(-15))
            make.bottom.equalTo(codeField.snp.bottom).offset(-MAL_Value(12))
            make.size.equalTo(CGSize.init(width: MAL_Value(85), height: MAL_Value(32)))
            
        }
        
        forgetPasswordBtn.snp.remakeConstraints { make in
            
            make.right.equalToSuperview().offset(-MAL_Value(30))
            make.top.equalTo(codeField.snp.bottom).offset(MAL_Value(20))
         
        }
        
        loginBtn.snp.remakeConstraints { make in
            
            make.bottom.equalToSuperview().offset(-MAL_Value(25))
            make.height.equalTo(MAL_Value(48))
            make.width.equalTo(MAL_Value(235))
            make.centerX.equalToSuperview()
            make.top.equalTo(forgetPasswordBtn.snp.bottom).offset(MAL_Value(20))
            
        }
        
        promLable.snp.remakeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(MAL_Value(35) + kBottomSafeAreaHeight))
            
            
            
        }
        
        
        
        
    }
    
    ///登录背景图
    lazy var backImageView: UIImageView = {
        
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFill
        view.image = MAL_ImageNamed("loginBackImage")
        return view
        
    }()
    
    lazy var loginItemView: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = .white
        setShadow(view: view, width: 0, sColor: UIColor.AppColor.alertBackgroundColor, opacity: 0.5, radius: MAL_Value(10))
        return view
    
    }()
    
    ///会员登录View
    lazy var memberBtnView: UIButton = {
        let view = UIButton.init(type:.custom)
        view.setTitle("会员登录", for: .normal)
        view.setTitleColor(UIColor.AppColor.main, for: .normal)
        view.setTitleColor(UIColor.white, for: .selected)
        view.isSelected = true
        view.backgroundColor = UIColor.AppColor.main
        view.titleLabel?.font = UIFont.szpAppleNormalFont(18)
        view.addTarget(self, action: #selector(selectedLoginType(_:)), for: .touchUpInside)
        return view
    }()
    ///报单中心登录View
    lazy var reportBtnView: UIButton = {
        let view = UIButton.init(type:.custom)
        view.setTitle("报单中心登录", for: .normal)
        view.setTitleColor(UIColor.AppColor.main, for: .normal)
        view.setTitleColor(UIColor.white, for: .selected)
        view.isSelected = false
        view.backgroundColor = UIColor.white
        view.titleLabel?.font = UIFont.szpAppleNormalFont(18)
        view.addTarget(self, action: #selector(selectedLoginType(_:)), for: .touchUpInside)
        
        return view
    }()
    
    @objc func selectedLoginType(_ sender: UIButton){
        
        if(sender == memberBtnView){
            
          
                
            reportBtnView.isSelected = false
            memberBtnView.isSelected = true
            reportBtnView.backgroundColor =  UIColor.white
            memberBtnView.backgroundColor =  UIColor.AppColor.main
            
            codeImageView.isHidden = false
            getcodeLable.isHidden = true
            
        }else{
           
           
            reportBtnView.isSelected = true
            memberBtnView.isSelected = false
            reportBtnView.backgroundColor = UIColor.AppColor.main
            memberBtnView.backgroundColor = UIColor.white
            
            codeImageView.isHidden = true
            getcodeLable.isHidden = false
           
        }
    
    }
    
    lazy var phoneBottomSlider: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = UIColor.init(hexColor: "#c8c8c8")
        return view
    
    }()
    
    private lazy var phoneField: SZPTextField = {
        let field = SZPTextField()
        field.clearButtonMode = .whileEditing
        field.keyboardType = .numberPad
        field.backgroundColor = .white
        field.addPaddingLeftIcon(MAL_ImageNamed("loginNum"), padding: 1)

        field.placeholder = "请输入会员编号".local
        field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // 这里必须设置，否则上下两个偏移不一样
        let rightImgBtn = UIButton.init(type: .custom)
        field.rightView = rightImgBtn
        field.rightViewMode = .never
        field.delegate = self
        return field
    }()
    
    lazy var passwordBottomSlider: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = UIColor.init(hexColor: "#c8c8c8")
        return view
    
    }()
    
    private lazy var passwordField: SZPTextField = {
        let field = SZPTextField()
        field.clearButtonMode = .whileEditing
        field.keyboardType = .numberPad
        field.backgroundColor = .white
        field.addPaddingLeftIcon(MAL_ImageNamed("passwordIcon"), padding: 1)

        field.placeholder = "请输入密码".local
        field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // 这里必须设置，否则上下两个偏移不一样
        let rightImgBtn = UIButton.init(type: .custom)
        field.rightView = rightImgBtn
        field.rightViewMode = .never
        field.delegate = self
        return field
    }()
    
    lazy var codeBottomSlider: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = UIColor.init(hexColor: "#c8c8c8")
        return view
    
    }()
    
    
    private lazy var codeField: SZPTextField = {
        let field = SZPTextField()
        field.clearButtonMode = .whileEditing
        field.keyboardType = .numberPad
        field.backgroundColor = .white
        field.addPaddingLeftIcon(MAL_ImageNamed("codeIcon"), padding: 1)

        field.placeholder = "请输入验证码".local
        field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // 这里必须设置，否则上下两个偏移不一样
        let rightImgBtn = UIButton.init(type: .custom)
        field.rightView = rightImgBtn
        field.rightViewMode = .never
        field.delegate = self
 
        return field
    }()
    

    
    lazy var getcodeLable: UILabel = {
        
        let view = UILabel.init()
        view.backgroundColor = UIColor.AppColor.main
        view.text = "获取验证码"
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont.szpAppleNormalFont(12)
        view.radiusView(MAL_Value(35) / 2.0)
        view.isHidden = true
        let tapGestur = UITapGestureRecognizer(target: self, action:#selector(sendMessage(_ :)))
        view.addGestureRecognizer(tapGestur)
         return  view
        
        
    }()
    @objc func sendMessage(_ tapGestur: UITapGestureRecognizer){
        
        
        
        
    }
    
    lazy var codeImageView: UIImageView = {
        
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .red
        return view
        
        
    }()
    
  
    
    lazy var forgetPasswordBtn: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.setTitle("忘记密码?", for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(12)
        view.setTitleColor(UIColor.init(hexColor: "#c8c8c8"), for: .normal)
        return view
        
    }()
    
    lazy var loginBtn: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.radiusView(MAL_Value(48) / 2.0)
        view.setTitle("登录", for: .normal)
        view.backgroundColor = UIColor.AppColor.main
        view.setTitleColor(UIColor.white, for: .normal)
        return view
       
    }()
    
    lazy var promLable: UILabel = {
        
        let view = UILabel.init()
        view.text = "欢迎您再次回来"
        view.font = UIFont.szpAppleNormalFont(12)
        view.textColor = UIColor.init(hexColor: "#c8c8c8")
        return view
    
    }()
    
    
    
    
    

    @objc private func textFieldDidChange(_ textField:UITextField) {
        
        
        
        
    }

}

extension MALLoginViewController: UITextViewDelegate, UITextFieldDelegate {
    
    
    
}
