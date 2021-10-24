//
//  MALApiPro.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import Moya

enum MALBillType:Int {
    case GWBList
    case JJBList
}



enum MALApiPro {
    case List(type:MALBillType, curPage:Int, pageSize:Int)
    case Out(param:MALDrawalParam)
}

extension MALApiPro: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        switch self {
        case .List(_,_,_):
            return "/asset/list"
        case .Out(_):
            return "/asset/cash/out"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        var paramter:[String:Any] = [:]
        
        switch self {
        case let .List(type, curPage, pageSize):
            paramter["billType"] = type.rawValue
            paramter["currentPage"] = curPage
            paramter["pageSize"] = pageSize
        case let .Out(param):
            paramter["bankName"] = param.bankName
            paramter["cardNo"] = param.cardNo
            paramter["cashAmount"] = param.cashAmount
            paramter["realName"] = param.realName
            paramter["secondPwd"] = param.secondPwd
            paramter["smsCode"] = param.smsCode
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
