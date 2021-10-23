//
//  SZPAPI.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/6/1.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit
import Moya

enum SZPAPI {

    case loginByPwd(parameters:[String:Any])
    case loginByCode(parameters:[String:Any])
    case otherLogin
}
extension SZPAPI: TargetType {


    var baseURL: URL {
        switch self {
        default:
            return URL.init(string: KMoyaBaseURL)!
        }
    }

    var path: String {
        switch self {
        case .loginByPwd:
            return "/api/app/login/pwdLogin"
        case .loginByCode:
            return "/api/app/login/codeLogin"
        default:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
//        case .loginByCode:
//            return .get
        default:
            return .post
        }
    }
    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    var task: Task {

        switch self {
        case let .loginByPwd(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .loginByCode(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
//            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
