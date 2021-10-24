//
//  MALHomeViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/23.
//

import UIKit

class MALHomeViewModel: NSObject {
    var model:MALHomeModel1?
    
    
    // 分类个数
    func getTypeCount() -> Int {
        model?.goodsTypeList?.count ?? 0
    }
    
    // 获取对应分类
    func getType(at index:Int) -> MALHomeGoodsTypeModel? {
        guard let model = model else {
            return nil
        }
        guard let types = model.goodsTypeList else {
            return nil
        }
        guard index < types.count else {
            return nil
        }
        return types[index]
    }
    
    func getGoodCount() -> Int {
        model?.goodsList?.count ?? 0
    }
    
    func getGood(at index:Int) -> MALHomeGoodModel? {
        guard let model = model  else {
            return nil
        }
        guard let goods = model.goodsList  else {
            return nil
        }
        guard index < goods.count else {
            return nil
        }
        return goods[index]
    }
}


extension MALHomeViewModel {
    
    func getHomeGoodInfo(success:@escaping (()->())) {
        
        kNetWorkRequest(MALApiHome.homeGood, needShowFailAlert: true, modelType: MALHomeModel1.self) {[weak self] model, res in
            guard let weakSelf = self else {
                return
            }
            weakSelf.model = model
            
            success()
            
        } failureCallback: { model in
            print("faile model: ", model.code, model.data)
        }
    }
    
    func searchGood(curPage:Int, pageSize:Int, goodName:String, success:(()->())) {
        kNetWorkRequest(MALApiHome.searchGood(currentPage: 0, pageSize: 1, goodName: "123"),
                        needShowFailAlert: true,
                        modelType: MALHomeModel1.self) {[weak self] model, res in
            guard let weakSelf = self else {
                return
            }

            if weakSelf.model == nil {
                weakSelf.model = model
            } else {
                weakSelf.model?.records = model?.records
            }
            
            print("records == ", weakSelf.model?.records?.count)
            
            
        } failureCallback: { model in
            print("faile model: ", model.code, model.data)
        }

        

    }
}
