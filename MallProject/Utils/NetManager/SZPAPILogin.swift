//
//  SZPAPILogin.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/6/2.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit
import Moya

/// 类型 REG :注册验证码, LOGIN:登录验证码, PAY_PASS:支付密码验证码, FORGET_PASS:登录密码找回验证码, BIND_MOBILE: 绑定手机号码, FORGET_PAY_PASS 忘记支付密码
enum SZPVerCodeType: String {
    case regist  = "REG"          // 注册验证码
    case login = "LOGIN"         // 登录验证码
    case pay = "PAY_PASS"      // 支付密码验证码
    case forget = "FORGET_PASS"  // 登录密码找回验证码,
    case bind = "BIND_MOBILE"   // 绑定手机号码
    case pay_forget = "FORGET_PAY_PASS"   // 忘记支付密码
}
/// 登录的api
enum SZPAPILogin {

    /// 注册账号: 通过验证码登录，直接注册账号，这里有一个默认密码
   // case registerAccount(mobile: String, vcode:String, pwd: String = "")
    ///首次设置登录密码
    case firstPassword(password:String)
    
    /// 密码登录
    case pwdLogin(mobile: String, password: String)
    /// 手机验证码登录
    case codeLogin(mobile: String, code: String)
    /// 验证忘记密码
    case getVerificationCode(mobile: String, code: String)
    // 找回密码 - 短信验证码方式
    case pwdChange(mobile: String, newPwd: String)
    /// 校验找回密码的验证码
    case pwdVerCodeCheck(mobile: String, code: String)
    ///  获取验证码
    case verCodeGet(mobile: String, type: SZPVerCodeType)
    /// 重置密码
    case pwdRest(oldPwd: String, newPwd: String)
    /// 获取阿里授权
    case getAliAuthor
    ////获取微信授权
    case getWeiXinAuthor(_ authCode: String)
    /// 阿里登录
    case loginByAli(_ authCode: String, _ alipay_open_id: String, _ user_id: String, _ result: String)
    
    //苹果登录
    case loginByApple
    
    ///  第三方登录 -绑定手机号码(通过三方账号第一次注册时绑定手机号码)
    case bindMobile(_ mobile: String, _ code: String, _ userID: String,_ invaCode:String?)
    
    case requsetLoginBindReferee( _ code: String, _ userID: String)
    
}

extension SZPAPILogin: TargetType {
    var baseURL: URL {
//        return URL.init(string: KMoyaBaseURL)!
        return URL.init(string: "KMoyaBaseURL")!
    }
    var path: String {
        switch self {
        case .requsetLoginBindReferee:
            return "/api/app/login/bindReferee"
        case .firstPassword:
            return "/api/app/my/config/settingPasswd/directSetting"
        case .getWeiXinAuthor:
        return "/api/app/tpi/login/wechat/appOauth"
       // case .registerAccount:
       //     return "/api/app/login/codeLogin"
        case .getVerificationCode:
            return "/api/app/my/config/forgetPayPasswd/checkCode"
        case .pwdLogin:
            return "/api/app/login/pwdLogin"
        case .codeLogin:
            return "/api/app/login/codeLogin"
        case .pwdChange:
            return "/api/app/login/upPassword"
        case .pwdVerCodeCheck:
            return "/api/app/login/checkForgetCode"
        case .verCodeGet:
            return "/api/app/login/getVCode"
        case .pwdRest:
            return "/api/app/login/doModifyLoginPwd"
        case .getAliAuthor:
            return "/api/app/tpi/login/alipay/getAuthInfo"
        case .loginByAli:
            return "/api/app/tpi/login/alipay/appOauth"
        case .bindMobile:
            return "/api/app/login/bindMobile"
            
        case .loginByApple:
            return "/api/app/tpi/login/alipay/appOauth"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {

        var parameters: [String:Any] = [:]
        
        switch self {
 //       case let .registerAccount(mobile, vcode, _):
//            parameters["mobile"] = mobile
//            parameters["vCode"] = vcode
//            parameters["pwd"] = pwd
//            parameters["confirmPwd"] = pwd
//            parameters["ivCode"] = ""       // 推荐码
//            parameters["isEncrypt"] = "0"   // 是否跳过加密（密码是RSA加密） 0跳过 1不跳过
        //    parameters["mobile"] = mobile
          //  parameters["code"] = vcode
          //  parameters["terminal"] = "0"
        case let .requsetLoginBindReferee(code, userID):
            parameters["userUuid"] = userID
            parameters["inviteCode"] = code
        case let .firstPassword(password):
            parameters["newPasswd"] = password
            parameters["confirmPasswd"] = password
        case let .getWeiXinAuthor(authcode):
            parameters["code"] = authcode
            parameters["terminal"] = "0"
        case let .getVerificationCode(mobile: mobile, code: vCode):
            parameters["mobile"] = mobile
            parameters["vCode"] = vCode
        case let .pwdLogin(mobile, passwd):
            parameters["mobile"] = mobile
            parameters["password"] = passwd
            parameters["terminal"] = "0"    // 0 iosapp 1安卓app 2微信小程序 3h5 4pc
            parameters["isEncrypt"] = "0" // 是否跳过加密（密码是RSA加密） 0跳过 1不跳过
        case let .codeLogin(mobile, code):
            parameters["mobile"] = mobile
            parameters["code"] = code
            parameters["terminal"] = "0"
        case let .pwdChange(mobile, newpwd):
            parameters["mobile"] = mobile
            parameters["newPwd"] = newpwd
            parameters["confirmPwd"] = newpwd
            parameters["checkToken"] = kUserDefaultRead(kdefaultToken) // "aab9cfa8-dc0d-4e1c-ab78-4eb280e6d1c3"
            parameters["isEncrypt"] = "0" // 是否加密0否 1是
        case let .pwdVerCodeCheck(mobile, code):
            parameters["mobile"] = mobile
            parameters["vCode"] = code
        case let .verCodeGet(mobile, type):
            parameters["mobile"] = mobile
            parameters["type"] = type.rawValue
        case let .pwdRest(oldpwd, newpwd):
            parameters["oldPwd"] = oldpwd
            parameters["newPwd"] = newpwd
            parameters["confirmPwd"] = newpwd
            parameters["isEncrypt"] = "0" // 是否加密0否 1是
        case let .loginByAli(authCode, alipay_open_id, user_id, result):
            parameters["authCode"] = authCode
            parameters["alipay_open_id"] = alipay_open_id
            parameters["user_id"] = user_id
            parameters["result"] = result
            parameters["terminal"] = "1"
        case let .bindMobile(mobile, code, userUuid,invaCode):
            parameters["mobile"] = mobile
            parameters["code"] = code
            parameters["userUuid"] = userUuid
            parameters["inviteCode"] = invaCode
        default:
                break
        }
        /// 这里要使用 URLEncoding 才能正常返回数据
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    var headers: [String : String]? {

        var dict: [String: String] = [:]
        dict = ["Content-Type":"application/x-www-form-urlencoded"]
        switch self {
        case .firstPassword,
             .pwdRest:
            dict["APP-Token"] =  kUserDefaultRead(kdefaultToken) // "登录的token"
        case .codeLogin:
            break
        default:
            
            dict["APP-Token"] =  kUserDefaultRead(kdefaultToken) // "登录的token"
            break
        }
        return dict
    }
}
