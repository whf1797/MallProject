//
//  MALCartViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit

class MALCartViewModel: NSObject {

}

extension MALCartViewModel {
    /**添加购物车*/
    func addCart(goodsID:Int, success:@escaping (()->())) {
        kNetWorkRequest(MALApiCart.Add(goodsId: goodsID), needShowFailAlert: true, modelType: MALCartResModel.self) { model, res in
            
        } failureCallback: { res in
            
        }
    }
    
    /**购物车列表*/
    func getCartList(curPage:Int, pageSize:Int, success:@escaping (()->())) {
        kNetWorkRequest(MALApiCart.List(curPage: curPage,
                                        pageSize: pageSize),
                        needShowFailAlert: true,
                        modelType: MALCartModel.self) {[weak self] model, res in
//            guard let weakSelf = self else {
//                return
//            }
            guard let records = model?.records else {
                return
            }
            let rec = records[0]
            
            print("records == ", records.count,rec.goodsName)
            
        } failureCallback: { res in
            
        }

    }
    /**移除购物车*/
    func removeCart(goodsID:Int, success:@escaping (()->())) {
        kNetWorkRequest(MALApiCart.Remove(goodsId: goodsID), needShowFailAlert: true, modelType: MALCartResModel.self) { model, res in
            
        } failureCallback: { res in
            
        }
    }

    /**更新购物车数量*/
    func updateCart(goodsId:Int, num:Int, success:@escaping (()->())) {
        kNetWorkRequest(MALApiCart.Update(goodsId: goodsId, num: num), needShowFailAlert: true, modelType: MALCartResModel.self) { model, res in
            
        } failureCallback: { res in
            
        }

    }
}

