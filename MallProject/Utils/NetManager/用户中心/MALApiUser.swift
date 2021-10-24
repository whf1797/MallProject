//
//  MALApiUser.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import Moya

protocol Addressable {
    func getAddress() -> String
    func getAreaId() -> Int
    func getConsignee() -> String
    func isDefault() -> Bool
    func getMobile() -> String
    func getProvinceId() -> Int
    
    
}

enum MALApiUser {
    case AddressList(curPage:Int, pageSize:Int)
    case AddAddress(param:Addressable)
    case DeleteAddress(id:Int)
    case UserInfo
    case InviteList(curPage:Int, pageSize:Int)
}

extension MALApiUser: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        switch self {
        case .AddressList:
            return "/user/address"
        case .AddAddress(_):
            return "/user/address/add"
        case .DeleteAddress(_):
            return "/user/address/del"
        case .UserInfo:
            return "/user/info"
        case .InviteList(_,_):
            return "/user/invite/list"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        var param:[String:Any] = [:]
        
        switch self {
        case let .AddressList(curPage, pageSize):
            param["currentPage"] = curPage
            param["pageSize"] = pageSize
        default:
            print("default")
        }
        
        return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        var dict: [String: String] = [:]
        dict = ["Content-Type":"application/json;charset=UTF-8"]
        dict["test"] = "%^%$7"
        dict["token"] = "wyralS/VM8UbafrkqSPuudVlgJ7RNh0r1C2QRrwr30TjpPJ1aSgaUmsYEn5NMMu6UoKKzH5M3zxj9QgBV02ZAw__"//UserDefaults.standard.value(forKey: "token") as! String
       
        return dict
    }
    
    
}
