//
//  MALOrderViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit

class MALOrderViewModel: NSObject {

    
}

extension MALOrderViewModel {
    func getOrderList(curPage:Int,
                      pageSize:Int,
                      key:String,
                      status:MALOrderStatus,
                      success:@escaping (()->())) {
        kNetWorkRequest(MALApiOrder.List(curPage: curPage,
                                         keywords: key,
                                         status: status,
                                         pageSize: pageSize),
                        needShowFailAlert: true,
                        modelType: MALOrderModel.self) { model, res in
            
        } failureCallback: { res in
            
        }

    }
    
    func createOrder(addressId:Int,
                     payType:MALPaytype,
                     list:[MALMakeOrderParamModel],
                     success:@escaping (()->())) {
        kNetWorkRequest(MALApiOrder.Create(addressID: addressId,
                                           payType: payType,
                                           list: list),
                        needShowFailAlert: true,
                        modelType: MALMakeOrderResModel.self) { model, res in
            
        } failureCallback: { res in
            
        }

    }
}
