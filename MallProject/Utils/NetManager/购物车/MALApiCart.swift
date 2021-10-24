//
//  MALApiCart.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import Moya

enum MALApiCart {
    case Add(goodsId:Int)
    case List(curPage:Int, pageSize:Int)
    case Remove(goodsId:Int)
    case Update(goodsId:Int,num:Int)
}

extension MALApiCart: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        switch self {
        case .Add(_):
            return "/cart/add"
        case .List(_,_):
            return "/cart/list"
        case .Remove:
            return "/cart/remove"
        case .Update:
            return "/cart/update"
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
        case let .Add(goodsId):
            print("add")
            paramter["goodsId"] = goodsId
        case let .List(curPage, pageSize):
            print("list")
            paramter["currentPage"] = curPage
            paramter["pageSize"] = pageSize
        case let .Remove(goodsId):
            print("remove")
            paramter["goodsId"] = goodsId
        case let .Update(goodsId,num):
            print("update")
            paramter["goodsId"] = goodsId
            paramter["num"] = num
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
