//
//  MALUserModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

/**
 "id": 1,
 "consignee": "陈强",
 "mobile": "18772231964",
 "provinceId": 130000,
 "provinceName": "河北省",
 "cityId": 130100,
 "cityName": "石家庄市",
 "areaId": 130102,
 "areaName": "长安区",
 "address": "1231",
 "isDefault": 1
 */

import UIKit
import HandyJSON


class AddressParmModel:Addressable {
    var address:String?
    var areaId:Int?
    var consignee:String?
    
    var cityId:Int?
    
    var cityName:String?
    var beDefault:Bool?
    var mobile:String?
    var provinceId:Int?
    
    func getAddress() -> String {
        return self.address ?? ""
    }
    
    func getAreaId() -> Int {
        return self.areaId ?? 0
    }
    
    func getConsignee() -> String {
        return self.consignee ?? ""
    }
    
    func isDefault() -> Bool {
        return self.beDefault ?? false
    }
    
    func getMobile() -> String {
        return self.mobile ?? ""
    }
    
    func getProvinceId() -> Int {
        return self.provinceId ?? 0
    }
}

class MALNetResBaseModel:NSObject, HandyJSON {
 
    required override init() {
        
    }
}


class MALAddressModel: NSObject, HandyJSON {
    
    var address:String?
    var areaId:Int?
    var areaName:String?
    var cityId:Int?
    
    var cityName:String?
    var id:Int?
    var isDefault:Bool?
    var mobile:String?
    var provinceId:Int?
    var provinceName:String?
    
    required override init() {
        
    }
}
class MALUserinfoModel: NSObject, HandyJSON {
    var userCode:String?
    var headImg:String?
    var expireDate:String?
    var shoppingAmount:String?
    var bonusAmount:String?
    var userLevelId:String?
    var userLevelName:String?
    
    required override init() {
        
    }
}


class MALAddressResModel: NSObject,HandyJSON {
    
    var records:[MALAddressModel]?
    required override init() {
        
    }
}




class MALUserModel: NSObject , HandyJSON{
    
    required override init() {
        
    }
    
}

class MALInviteOrder: NSObject, HandyJSON {
    var asc:Bool?
    var column:String?
    required override init() {
        
    }
    
}

class MALInviteRecord: NSObject, HandyJSON {
    var gmtCreated:String = "" // 疫情时间
    var level:Int?
    var nickName:String?
    var status:String?
    var totalLeftPerformance:Double?
    var totalRightPerformance:Double?
    var userCode:String?
    var userName:String?
    required override init() {
        
    }
}

class MALInviteModel: NSObject, HandyJSON {
    var orders:[MALInviteOrder]?
    var records:[MALInviteRecord]?
    var countId:String?
    var current:Int?
    var hitCount:Bool?
    var maxLimit:Int?
    var optimizeCountSql:Bool?
    
    
    required override init() {
        
    }
    
    
}
