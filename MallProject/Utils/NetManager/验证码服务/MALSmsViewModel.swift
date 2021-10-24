//
//  MALSmsViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit

class MALSmsViewModel: NSObject {

}

extension MALSmsViewModel {
    
    func reqPicSms(success:@escaping (()->())) {
        kNetWorkRequest(MALApiSms.Pic, needShowFailAlert: true, modelType: MALSmsModel.self) { model, res in
            
        } failureCallback: { res in
            
        }

    }
    
    func reqCodeSms(type:MALSmsType, mobile:String, userCode:String, success:@escaping (()->())) {
        kNetWorkRequest(MALApiSms.Sms(bizType: type,
                                      mobile: mobile,
                                      userCode: userCode),
                        needShowFailAlert: true, modelType: MALSmsModel.self) { model, res in
            
        } failureCallback: { res in
        
        }

    }
}
