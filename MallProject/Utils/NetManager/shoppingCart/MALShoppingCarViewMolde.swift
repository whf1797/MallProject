//
//  MALShoppingCarViewMolde.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/24.
//

import UIKit

class MALShoppingCarViewMolde: NSObject {

}

extension MALShoppingCarViewMolde {
    
    ///获取购物车列表
    func getShoppingCartList(currentPage: Int, pageSize:Int, responseBlock:@escaping (_ cartListModel:MALCartListModel?) -> Void) {
        
        kNetWorkRequest(MALAPIShoppingCar.getShoppingCartList(currentPage, pageSize),
                        modelType: MALCartListModel.self) { model, responseModel in
            
            responseBlock(model ?? MALCartListModel.init())
            
        }
    }
    
    ///修改购物车数量
    func changeShopCarGoodsNum( goodsId: Int, num:Int, responseBlock:@escaping (_ code:Int, _ message: String) -> Void){
        
        
        kNetWorkRequest(MALAPIShoppingCar.changeShopCarGoodsNum(goodsId, num),
                        modelType: MALEmptyModel.self) { model, responseModel in
            
            responseBlock(responseModel?.code ?? 0 , responseModel?.message ?? "")
        
        
      }
    
    }
    
    ///删除商品购物车
    func removeShopCarGoodsNum( goodsId: Int, responseBlock:@escaping (_ code:Int, _ message: String) -> Void){
        
        
        kNetWorkRequest(MALAPIShoppingCar.removeShopCarGoodsNum(goodsId),
                        modelType: MALEmptyModel.self) { model, responseModel in
            
            responseBlock(responseModel?.code ?? 0 , responseModel?.message ?? "")
        
        
      }
    
    }
    
}
