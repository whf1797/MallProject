//
//  SZPAPILogin.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/6/2.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit
import Moya


enum MALAPIShoppingCar {


    ///获取购物车列表
    case getShoppingCartList(_ currentPage: Int, _ pageSize: Int)
    
    /// 修改购物车数量
    /// - Parameters: goodsId ,num
    case changeShopCarGoodsNum(_ goodsId:Int,_ num: Int)
    
    /// 删除购物车商品
    /// - Parameters: goodsId
    case removeShopCarGoodsNum(_ goodsId:Int)
    
}

extension MALAPIShoppingCar: TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    var path: String {
        switch self {
        case .getShoppingCartList:
            return "/cart/list"
        case .changeShopCarGoodsNum:
            return "/cart/update"
        case .removeShopCarGoodsNum:
            return "/cart/remove"
    
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
        case let .getShoppingCartList(currentPage,pageSize):
            parameters["currentPage"] = currentPage
            parameters["pageSize"] = pageSize
        case let .changeShopCarGoodsNum(goodsId, num):
            parameters["goodsId"] = goodsId
            parameters["num"] = num
        case let .removeShopCarGoodsNum(goodsId):
            parameters["goodsId"] = goodsId
        }
     
        /// 这里要使用 URLEncoding 才能正常返回数据
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
    var headers: [String : String]? {

        var dict: [String: String] = [:]
        dict = ["Content-Type":"application/json"]
        switch self {
     
        default:
            dict["test"] = "1234"
            dict["token"] = "8E9MciNrKA8uQtBOfclzYaxB4ecbs6K76G28+BrynOC5PocsUMxgwsyti4B4x1ADwfwzJAk6HbF1O2vTSx/3zA__"  //kUserDefaultRead(kdefaultToken)  // "登录的token"
            break
        }
        return dict
    }
}
