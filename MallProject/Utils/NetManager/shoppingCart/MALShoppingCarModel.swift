//
//  MALShoppingCarModel.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/24.
//

import UIKit
import HandyJSON





struct MALEmptyModel: HandyJSON {

    var responseString: String?
    var orderNo: String?
    var orderStr: String?
    /// /api/app/tpi/login/alipay/getAuthInfo
    var aliLoginAuthor: String?
    /// 映射属性
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.responseString <-- "purchaseVipLogUUID" /// vip购买：/api/app/my/purchaseVip
        mapper <<< self.orderNo <-- "orderNo" /// 确定支付(创建订单) /api/app/my/order/createOrders 和 /api/app/my/order/immediatelyPayment
        mapper <<< self.orderStr <-- "orderStr" /// 支付宝APP支付创建订单串 /api/app/my/order/createAlipayAppPayOrderStr
        mapper <<< self.aliLoginAuthor <-- "authInfo"
    }
}

struct MALCartListModel: HandyJSON {

    
    var countId: String?
    var current: Int?
    var hitCount: Bool?
    var maxLimit: String?
    var optimizeCountSql: Bool?
    var records =  [MALCarRecordsModel]()
    
    
}
struct MALCarRecordsModel: HandyJSON {
   
    ///商品名称
    var goodsName: String?
    /// 商品ID
    var id: Int?
    ///图片
    var imgUrl: String?
    /// 商品数量
    var num: String?
    /// 价格
    var price: String?
    
    var iSSelected: Bool = false
    
    
}
