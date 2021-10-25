//
//  SZPMallModel.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/6/7.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit
import HandyJSON



struct SZPBannerModel: HandyJSON {
    var banners = [SZPBannerItem]()
}
/// 轮播图 Model
struct SZPBannerItem: HandyJSON {

    /// banner图片的url
    var bannerUrl: String?

    /// 1.业务记录的uuid 跳详情时配合types使用 2.link_types为3的时候改参数表示h5链接
    var bussUuid: String?

   
    var linkTypes: String?

    var sort: Int = 0

    /// 标题
    var title: String?

    /// 不同业务的types 对应orders里面的types 1实战课程 2实战课程包 3线上课程 4直播课程 5直播课程包 6实地学习 7商品
    var types: String?

    /// banner的Uuid
    var uuid: String?
}

/// 实物购物车商品 Model
struct SZPCartGoodsItem: HandyJSON {

    var goodsId:String?
    /// 商品ID
    var cartUUID: String?
    
    ///封面图
    var frontUrl : String?
    /// 封面图
    var coverUrl: String?
    /// 是否失效 1失效0 为失效
    var isInvalid: String?
    /// - 使用此价格
    var price: String?
    ///     属性
    var property: String?
    /// 数量
    var quantity: String?
    var title: String?
    var name: String?
    /// 1实战课程 2实战课程包 3线上课程 4直播课程 5直播课程包 6实地学习 7商品
    var types: String?
    /// vip价格
    var vipPrice: String?
    /// 课程简介
    var simpleIntroduce: String?
}

/// 商品详情 Model
struct SZPMallDetailModel: HandyJSON {

    /// 评价数量
    var appraise: Int = 0
    /// 详情
    var details = [String]()
    /// 是否是收藏商品有值表示有带着uuid,没有就是没有收藏
    var isFavorites: String?
    /// 是否为多规格 0否 1是
    var isRange: String?
    /// 市场价格
    var marketPrice: Float = 0.0
    /// 商品名称
    var name: String?
    /// 商品轮播图
    var slideshow = [String]()
    /// 已售数量
    var soldQuantity: Int = 0
    /// 商品ID
    var uuid: String?
    /// vip价格
    var vipPrice: CGFloat = 0
}


/// 商城 model
struct MALMallModel: HandyJSON {

    /// 商品图片
    var coverPicture: String?

    /// 市场价
    var marketPrice: String?

    /// 名称
    var name: String?

    /// 商品的分类uuid
    var uuid: String?

    /// vip价格
    var vipPrice: String?
}

struct SZPCartModel: HandyJSON {


    /// 有效列表
    var validList = [SZPCartGoodsItem]()



//    /// 映射属性
//    mutating func mapping(mapper: HelpingMapper) {
//        mapper <<< self.outTimeGoodsVo <-- "OutTimeGoodsVo"
//    }
}

