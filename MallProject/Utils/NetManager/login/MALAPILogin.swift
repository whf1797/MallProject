//
//  MALAPILogin.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/23.
//

import UIKit
import Moya

enum MALLoginUserType : Int {
    case user = 1 // 普通会用
    case worker = 2 // 保单中心 工作人员
}




enum MALAPILogin {
//    case
    case loginWithPwd(pwd:String, userCode:String, userType:MALLoginUserType)
    case loginWithSms(sms:String, userCode:String, userType:MALLoginUserType)
}

extension MALAPILogin: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        return  "/user/login"
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
        case let .loginWithPwd(pwd, userCode , userType):
            print("密码登录")
            parameters["loginType"] = userType.rawValue
            parameters["password"] = pwd
            parameters["userCode"] = userCode
            
        case let .loginWithSms(sms , userCode , userType):
            print("验证码登录")
            parameters["loginType"] = userType.rawValue
            parameters["smsCode"] = sms
            parameters["userCode"] = userCode
        }

        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        
    }
    
    var headers: [String : String]? {
        var dict: [String: String] = [:]
        dict = ["Content-Type":"application/json;charset=UTF-8"]
        dict["test"] = "%^%$7"
       
        return dict
    }
    
    
}
