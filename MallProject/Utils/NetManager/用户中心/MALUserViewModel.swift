//
//  MALUserViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit

class MALUserViewModel: NSObject {
    var userInfo:MALUserinfoModel? // 用户信息
    
  
    
}

extension MALUserViewModel {
    /**
     获取地址列表
     */
    func getAddressList(curPage:Int, pageSize:Int) {
        kNetWorkRequest(MALApiUser.AddressList(curPage: curPage,
                                               pageSize: pageSize),
                        needShowFailAlert: true, modelType: MALAddressResModel.self) { model, res in
            print("get address == ", model?.records?.count)
            guard let records = model!.records else {
                return
            }
            
            let add = records[0]
            print("model", add.cityId, add.cityName)
            
        } failureCallback: { res in
            
        }
    }


    /**
     添加地址
     */
    func addAddress(param:Addressable) {
        kNetWorkRequest(MALApiUser.AddAddress(param: param),
                        needShowFailAlert: true,
                        modelType: MALNetResBaseModel.self) { model, res in
            if res?.code ?? -99 == 100 {
                print("address success")
            } else {
                print("address failed")
            }
            
        } failureCallback: { res in
            
        }

    }
    
    /**
     */
    func getUserInfo(success:@escaping (()->())) {
        kNetWorkRequest(MALApiUser.UserInfo, needShowFailAlert: true,
                        modelType: MALUserinfoModel.self) {[weak self] model, res in
            
            print("info === ", model?.userCode, model?.userLevelName)
        } failureCallback: { res in
            
        }

    }
    /**
     获取推荐列表
     */
    func getInviteList(curPage:Int, pageSize:Int, success:@escaping (()->())) {
        kNetWorkRequest(MALApiUser.InviteList(curPage: curPage,
                                              pageSize: pageSize),
                        needShowFailAlert: true,
                        modelType: MALInviteModel.self) { model, res in
            
            guard let records = model?.records else {
                return
            }
            let rec = records[0]
            print("model === ", rec.nickName)
            
            
            
            
        } failureCallback: { res in
            
        }

    }
}
