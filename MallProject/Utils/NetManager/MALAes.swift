//
//  MALAes.swift
//  MallProject
//
//  Created by 王洪飞 on 2021/10/23.
//

import UIKit
import CryptoSwift

class MALAes: NSObject {

    static func Encode_AES_ECB(strToEncode:String) -> String {
        // string to data
        let data = strToEncode.data(using: .utf8)
        
        // byte 数组
        var encryped:[UInt8] = []
        
        do {
            
            try encryped = AES(key: "==AA(d)erp211985", iv: "ia32ldh4#2s-sd=s").encrypt(data!.bytes)
        } catch  {
            
        }
        let encoded = Data(encryped)
        
        return encoded.base64EncodedString()
    }
    
}


extension MALAes {
//    static let 'default'
}
