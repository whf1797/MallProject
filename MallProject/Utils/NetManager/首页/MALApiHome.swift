//
//  MALApiHome.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/23.
//

import UIKit
import Moya

enum MALApiHome {
    case homeGood
    case goodDetail(id:Int)         // 获取详情
    case searchGood(currentPage:Int, pageSize:Int, goodName:String) // 搜索
}

extension MALApiHome: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        
        switch self {
        case .homeGood:
            return  "/goods/index"
        case .goodDetail(_):
        return  "/goods/index"
        case .searchGood(_,_, _):
            return "/goods/search"
        }
        
    }
    
    var method: Moya.Method {
        .post
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        
        switch self {
        case .homeGood:
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        
        case .goodDetail(_):
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
            
        case let .searchGood(currentPage, pageSize, goodName):
            let parameter:[String:Any] = [
                "currentPage": currentPage,
                "goodsName": goodName,
                "pageSize": pageSize
            ]
        return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
        
        
        }
        
    }
    
    var headers: [String : String]? {
        var dict: [String: String] = [:]
        dict = ["Content-Type":"application/json;charset=UTF-8"]
        dict["test"] = "%^%$7"
        dict["token"] = "wyralS/VM8UbafrkqSPuudVlgJ7RNh0r1C2QRrwr30TjpPJ1aSgaUmsYEn5NMMu6UoKKzH5M3zxj9QgBV02ZAw__"//UserDefaults.standard.value(forKey: "token") as! String
       
        return dict
    }
    
    
}
