//
//  MALHomeModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import HandyJSON

class MALHomeGoodsTypeModel: NSObject, HandyJSON {
    var id:Int?
    var name:String?
    
    required override init() {
        
    }
}

class MALHomeGoodModel: NSObject, HandyJSON {
    var id:Int?
    var goodsName:String?
    var imgUrl:String?
    var price:Double?
    var num:Int?
    required override init() {
    }
}

class MALHomeModel1: NSObject, HandyJSON {

    var goodsTypeList:[MALHomeGoodsTypeModel]? // 分类列表
    var goodsList:[MALHomeGoodModel]?   // 首页产品列表
    var notice:String?  // 公告
    var records:[MALHomeGoodModel]? // 搜索列表
    
    
    func mapping(mapper: HelpingMapper) {
        
    }
    
    required override init() {
        
    }
}
