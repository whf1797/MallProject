//
//  SZPLoginViewModel.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/4/20.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit

class SZPLoginViewModel: NSObject {

}

extension SZPLoginViewModel {

    /// 登录：密码
    func loginByPassword(_ mobile: String, _ password: String, tokenResponseBlock:@escaping (_ token:String) -> Void) {
        
        MALAutoProgressHUD.showHud("登录中")

        kNetWorkRequest(SZPAPILogin.pwdLogin(mobile: mobile, password: password), modelType: SZPLoginModel.self) { (loginModel, _ ) in
            
            
            kUserDefaultWrite(kDefaultPhone,mobile)
            kUserDefaultWrite(kdefaultUserIsIdentification, loginModel?.isIdentification ?? "0")
            kUserDefaultWrite(kdefaultUserNickname, loginModel?.nickname ?? "")
            kUserDefaultWrite(kdefaultUserVipLevel, loginModel?.vipLevel ?? "1")
            kUserDefaultWrite(kdefaultUserLevel, loginModel?.level ?? "1")
            kUserDefaultWrite(kdefaultUserUUID, loginModel?.userUuid ?? "")
            kUserDefaultWrite(kdefaultUserNickname, loginModel?.nickname ?? "")
            
            SZPAutoProgressHUD.hideHud()
           
            if(kAppStorePhone == mobile){
             
                kUserDefaultWrite(reviewTheStatus, "1")
                UserDefaults.standard.synchronize()
                
            }else{
               
                kUserDefaultWrite(reviewTheStatus, "0")
                UserDefaults.standard.synchronize()
            }
            UserDefaults.standard.synchronize()
            
            
         
            if let token = loginModel?.appToken {
                

                kUserDefaultWrite(kdefaultToken, token)
                SZPLog.d(" 获取到的token是： \(token)")
                tokenResponseBlock(token)
            }
            
        }
    }
    
    /// 忘记支付密码 - 检验验证码
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - vCode: 验证码 从公共模块中【获取验证码】接口获取
    func getVerificationCode(_ mobile: String, _ vcode: String, successBlock:( (_ checkModel: SZPLoginCheckVCodeModel?) -> Void)?) {

        kNetWorkRequest(SZPAPILogin.getVerificationCode(mobile: mobile, code: vcode), modelType: SZPLoginCheckVCodeModel.self) { checkModel,resultModel  in

            guard let block = successBlock else { return }
            block(checkModel)
        }
    }
    
    

    /// 获取验证码
    /// - Parameters:
    ///   - mobile: 手机号码
    ///   - type: 验证码类型，默认 .login
    func getVerCode(_ mobile: String, type: SZPVerCodeType = .login, _ responseBlock: @escaping () -> Void) {
        
        
        kNetWorkRequest(SZPAPILogin.verCodeGet(mobile: mobile, type: type), modelType: SZPLoginModel.self) { (_, _) in
            responseBlock()
        }failureCallback:  {(error) in
            
        
            
        }
    }
    /// 注册账号：验证码
    func register(_ mobile: String, _ vcode: String, _ pwd: String, successBlock:( () -> Void)?) {

        kNetWorkRequest(SZPAPILogin.codeLogin(mobile: mobile, code: vcode), modelType: SZPLoginModel.self) { (loginModel, resultModel) in

            guard let block = successBlock else { return }
            block()
        }
    }
    /// 登录：验证码
    func loginByCode(_ mobile: String, _ code: String, tokenResponseBlock:@escaping (_ token:String) -> Void) {

        /// 验证码注册
        SZPAutoProgressHUD.showHud("登录中")
        kNetWorkRequest(SZPAPILogin.codeLogin(mobile: mobile, code: code), modelType: SZPLoginModel.self) { (loginModel, _) in

            if let token = loginModel?.appToken {

                kUserDefaultWrite(kdefaultToken, token)
                SZPLog.d(" 用户注册成功，获取到的token是： \(token)")
            }
        
                kUserDefaultWrite(kDefaultPhone,mobile)
                kUserDefaultWrite(kdefaultToken, loginModel?.appToken ?? "")
                kUserDefaultWrite(kdefaultUserUUID, loginModel?.userUuid ?? "")
                kUserDefaultWrite(kdefaultUserNickname, loginModel?.nickname ?? "")
                kUserDefaultWrite(kdefaultUserVipLevel, loginModel?.vipLevel ?? "1")
                kUserDefaultWrite(kdefaultUserLevel, loginModel?.level ?? "1")
                kUserDefaultWrite(kdefaultUserIsIdentification, loginModel?.isIdentification ?? "0")
                SZPAutoProgressHUD.hideHud()
            
           
            if(kAppStorePhone == mobile){
             
                kUserDefaultWrite(reviewTheStatus, "1")
                UserDefaults.standard.synchronize()
                
            }else{
               
                kUserDefaultWrite(reviewTheStatus, "0")
                UserDefaults.standard.synchronize()
            }
            
                UserDefaults.standard.synchronize()
            
            if(loginModel?.isNew == 0){
            
                tokenResponseBlock(loginModel?.appToken ?? "")
                
            }else{

            let currentVC = UIViewController.getTopViewController()
              let invitationView = SZPInvitationViewController()
            
             currentVC?.navigationController?.pushViewController(invitationView)
            
            }
            
                
            
            
           
            
            
            
        }
    }

    /// 忘记密码，校验验证码
    func forgetCheckVcode(_ mobile: String, _ code: String, successBlock:(() -> Void)?) {
        kNetWorkRequest(SZPAPILogin.pwdVerCodeCheck(mobile: mobile, code: code), modelType: SZPLoginCheckVCodeModel.self) { (checkModel, _ ) in
            if let token = (checkModel?.checkToken) {
                kUserDefaultWrite(kdefaultToken, token)
            }
            guard let block = successBlock else { return }
            block()
        }
    }
    ///第一次设置密码
    func firstPassword(_ pwd: String,_ successBlock:((_ code:Int) -> Void)?){
        
        kNetWorkRequest(SZPAPILogin.firstPassword(password: pwd), modelType: SZPLoginModel.self) { (loginModel, resultModel) in

            guard let block = successBlock else { return }
            block(resultModel?.code ?? 0)
        }
        
    }

    /// 重置密码
    func resetPassword(_ oldPwd: String, _ pwd: String, successBlock:(() -> Void)?) {

        kNetWorkRequest(SZPAPILogin.pwdRest(oldPwd: oldPwd, newPwd: pwd), modelType: SZPLoginModel.self) { (loginModel, resultModel) in

            guard let block = successBlock else { return }
            block()
        }
    }

    /// 找回密码
    func getPassword(_ mobile: String, _ pwd: String, successBlock:((_ success: Bool) -> Void)?) {

        kNetWorkRequest(SZPAPILogin.pwdChange(mobile: mobile, newPwd: pwd), modelType: SZPEmptyModel.self) { (model, resultModel) in

            guard let block = successBlock else { return }
            block(resultModel?.code == 200)
        }
    }

    /// 阿里登录授权
    func getAliLoginAuthor(_ responseBlock:((_ authorInfo: String?) -> Void)?) {

        kNetWorkRequest(SZPAPILogin.getAliAuthor, modelType: SZPEmptyModel.self) { (model, resultModel) in

            guard let block = responseBlock else { return }
            block(model?.aliLoginAuthor)
        }
    }
    
    /// 获取微信登录权限
    func getauthcode( _ aucode:String , _ responseBlock:((_ authorInfo: SZPLoginAliModel?) -> Void)?) {

        kNetWorkRequest(SZPAPILogin.getWeiXinAuthor(aucode), modelType: SZPLoginAliModel.self) { (model, resultModel) in

            guard let block = responseBlock else { return }
            block(model)
        }
    }
    

    /// 阿里授权登录（注册）
    func loginByAli(_ authCode: String?, _ alipay_open_id: String?, _ user_id: String?, _ result: String?, _ responseBlock:((_ authorInfo: SZPLoginAliModel?) -> Void)?) {

        kNetWorkRequest(SZPAPILogin.loginByAli(authCode!, alipay_open_id!, user_id!, result!), modelType: SZPLoginAliModel.self) { (model, _) in
            guard let block = responseBlock else { return }
            block(model)
        }
    }
    
    /// 苹果登录授权(注册)
    
    /// 短信登录 -绑定邀请人
    func requsetLoginBindReferee(_ code: String?, _ user_id: String?, _ responseBlock:((_ authorInfo: SZPLoginUserModel?) -> Void)?) {
        kNetWorkRequest(SZPAPILogin.requsetLoginBindReferee(code!, user_id!), modelType: SZPLoginUserModel.self) { (model, _) in
            guard let block = responseBlock else { return }
            block(model)
        }
    }
    

    /// 第三方登录 -绑定手机号码(通过三方账号第一次注册时绑定手机号码)
    func requestBindMobile(_ mobile: String?, _ code: String?, _ user_id: String?, _ inviteco: String?, _ responseBlock:((_ authorInfo: SZPLoginUserModel?) -> Void)?) {
        kNetWorkRequest(SZPAPILogin.bindMobile(mobile!, code!, user_id!,inviteco), modelType: SZPLoginUserModel.self) { (model, _) in
            guard let block = responseBlock else { return }
            block(model)
        }
    }
}
