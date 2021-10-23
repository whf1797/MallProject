//
//  MALLoginViewModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/23.
//

import UIKit

class MALLoginViewModel: NSObject {

}

extension MALLoginViewModel {
    func loginWithPwd(pwd:String, userCode:String,
               userType:MALLoginUserType,
               tokenResponseBlock:@escaping (_ token:String) -> Void) {
        kNetWorkRequest(MALAPILogin.loginWithPwd(pwd: pwd,
                                                 userCode: userCode,
                                                 userType: userType),
                        modelType: MALMallModel.self) { model, res in
            
        }
    }
    
    func loginWithSms(sms:String, userCode:String,
               userType:MALLoginUserType,
               tokenResponseBlock:@escaping (_ token:String) -> Void) {
        kNetWorkRequest(MALAPILogin.loginWithSms(sms: sms,
                                                 userCode: userCode,
                                                 userType: userType),
                        modelType: MALMallModel.self) { model, res in
            
        }
    }
}
