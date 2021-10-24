//
//  MALProModel.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/24.
//

import UIKit
import HandyJSON

class MALDrawalParam: NSObject {
    var bankName:String?
    var cardNo:String?
    var cashAmount:Double?
    var realName:String?
    var secondPwd:String?
    var smsCode:String?
    
    
    init(bankName:String,
         cardNo:String,
         cashAmt:Double,
         realName:String,
         secPwd:String,
         smsCode:String) {
        self.bankName = bankName
        self.cardNo = cardNo
        self.cashAmount = cashAmt
        self.realName = realName
        self.secondPwd = secPwd
        self.smsCode = smsCode
    }
    
}

class MALProModelRecord: NSObject, HandyJSON {
    var amount:Double?
    var billType:String?
    var consAmount:Int?
    var gmtCreate:String?
    var remarks:String?
    
    required override init() {
        
    }
}

class MALProModel: NSObject, HandyJSON {
    
    var records:[MALProModelRecord]?
    
    
    required override init() {
        
    }
}

class MALDrawalModel: NSObject, HandyJSON {
    
    required override init() {
        
    }
}
