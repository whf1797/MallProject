//
//  MALCartModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import HandyJSON


class MALCartModelRecord: NSObject, HandyJSON {
    var goodsName:String?
    var id:Int?
    var imgUrl:String?
    var num:Int?
    var price:Double?
    required override init() {
        
    }
}

class MALCartModel: NSObject, HandyJSON {

    var records:[MALCartModelRecord]?
    
    
    required override init() {
        
    }
}

class MALCartResModel: NSObject, HandyJSON {
    
    var code:Int?
    var encData:String?
    var message:String?
    
    required override init() {
        
    }
}
