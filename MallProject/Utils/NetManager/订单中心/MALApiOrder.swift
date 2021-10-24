//
//  MALApiOrder.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import Moya

/**
 定单状态 0 待支付 1 已支付 2 部分发货 3 已发货 4 交易完成 10 取消订单
 */
enum MALOrderStatus : Int {
    /**
     待支付
     */
    case WaitForPay = 0
    /**
     已支付
     */
    case HavePayed = 1
    /**
     部分发货
     */
    case PartialSetout = 2
    /**
     已发货
     */
    case AllSetout = 3
    /**
     交易完成
     */
    case Payed = 4
    /**
     取消订单
     */
    case Canceled = 10
}

/**
 支付方式, 0 购物币 1 奖金币
 */
enum MALPaytype:Int {
    /**0 购物币*/
    case GWB = 0
    /**1 奖金币*/
    case JJB = 1
}

enum MALApiOrder {
    case Create(addressID:Int,payType:MALPaytype, list:[MALMakeOrderParamModel])
    case List(curPage:Int,keywords:String,status:MALOrderStatus,pageSize:Int)
    case Detail(codeId:Int)
}

extension MALApiOrder : TargetType {
    var baseURL: URL {
        return URL.init(string: KMoyaBaseURL)!
    }
    
    var path: String {
        switch self {
        case .Create:
            return "/order/create"
        case .List(_,_,_,_):
            return "/order/list"
        case .Detail(_):
            return "/order/detail"
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
        case let .Create(addressID,payType, list):
            paramter["addressId"] = addressID
            paramter["payType"] = payType.rawValue
            
            var ary:[[String:Any]] = [[:]]
            for item in list {
                let dic:[String:Int] = [
                    "goodsId": item.goodsId ?? 0,
                    "goodsNum": item.goodsNum ?? 0
                ]
                ary.append(dic)
            }
            paramter["orderItemList"] = ary
            print("param == ",paramter)
        case let .List(curPage, keywords, status, pageSize):
            paramter["currentPage"] = curPage
            paramter["keywords"] = keywords
            paramter["orderStatus"] = status.rawValue
            paramter["pageSize"] = pageSize
            
            
        case let .Detail(codeId):
            paramter["orderId"] = codeId
            
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
