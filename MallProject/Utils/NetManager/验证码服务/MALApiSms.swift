//
//  MALAipSms.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import Moya

/**
 业务类型：login登录验证码，cash_out提现,password忘记密码
 */
enum MALSmsType:Int {
    /**login登录验证码*/
    case Login
    /**cash_out提现*/
    case CashOut
    /**password忘记密码*/
    case ForgetPwd
}

enum MALApiSms {
    case Pic
    case Sms(bizType:MALSmsType, mobile:String, userCode:String)
}


extension MALApiSms: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        switch self {
        case .Pic:
            return "/code/pic/send"
        case .Sms:
            return "/code/sms/send"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Pic:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        var paramter:[String:Any] = [:]
        
        switch self {
        case .Pic:
            print("==")
        case let .Sms(bizType, mobile, userCode):
            paramter["bizType"] = bizType.rawValue
            paramter["mobile"] = mobile
            paramter["userCode"] = userCode
        }
        
        
        return .requestParameters(parameters: paramter, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        var dict: [String: String] = [:]
        dict = ["Content-Type":"application/json;charset=UTF-8"]
        dict["test"] = "%^%$7"
        dict["token"] = "wyralS/VM8UbafrkqSPuudVlgJ7RNh0r1C2QRrwr30TjpPJ1aSgaUmsYEn5NMMu6UoKKzH5M3zxj9QgBV02ZAw__"//UserDefaults.standard.value(forKey: "token") as! String
       
        return dict
    }
    
    
}
