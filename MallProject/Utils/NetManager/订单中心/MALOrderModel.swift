//
//  MALOrderModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import HandyJSON

/**
 确定顶点参数
 */
class MALMakeOrderParamModel: NSObject {
    var goodsId:Int?
    var goodsNum:Int?
    
    init(id:Int, num:Int) {
        self.goodsId = id
        self.goodsNum = num
    }
}

class MALMakeOrderResModel: NSObject, HandyJSON {
    var code:Int?
    var message:String?
    
    required override init() {
        
    }
}


class MALOrderOrder: NSObject,HandyJSON {
    
    required override init() {
        
    }
}

class MALOrderRecord: NSObject,HandyJSON {
    
    required override init() {
        
    }
}

class MALOrderModel: NSObject,HandyJSON {

    var records:[MALOrderRecord]?
    var orders:[MALOrderOrder]?
    required override init() {
        
    }
}
