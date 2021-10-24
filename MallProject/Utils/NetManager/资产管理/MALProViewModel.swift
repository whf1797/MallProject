//
//  MALProViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit

class MALProViewModel: NSObject {

}


extension MALProViewModel {
    /**提现*/
    func reqDrawal(param:MALDrawalParam, success:@escaping (()->())) {
        kNetWorkRequest(MALApiPro.Out(param: param), needShowFailAlert: true, modelType: MALDrawalModel.self) { model, res in
            
        } failureCallback: { res in
            
        }

    }
    
    /**资金明细*/
    func reqProList(type:MALBillType,
                    curPage:Int,
                    pageSize:Int,
                    success:@escaping (()->())) {
        kNetWorkRequest(MALApiPro.List(type: type, curPage: curPage, pageSize: pageSize), needShowFailAlert: true, modelType: MALProModel.self) { model, res in
            
        } failureCallback: { res in
            
        }

    }
    
}
