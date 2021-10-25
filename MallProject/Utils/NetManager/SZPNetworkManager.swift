//
//  SZPNetworkManager.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/6/1.
//  Copyright © 2021 Suo. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import HandyJSON
import SwiftyJSON

/// 超时时间
private var requestTimeOut: Double = 30
/// 返回对象的json结构
let dataKey = "data"
let messageKey = "msg"
let codeKey = "code"
let successCode: Int = 200

typealias RequestModelSuccessCallBack<T:HandyJSON> = ((T?, ResponseModel?) -> Void)

typealias RequestModelsSuccessCallback<T:HandyJSON> = (([T], ResponseModel?) -> Void)

typealias RequestFailureCallback = ((ResponseModel) -> Void)

typealias ErrorCallback = (() -> Void)

/// 网络请求，当模型为dict类型
/// - Parameters:
///   - target: 接口
///   - showFailAlert: 是否显示网络请求失败的弹框
///   - modelType: 模型
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
@discardableResult
func kNetWorkRequest<T: HandyJSON>(_ target: TargetType,
                                   needShowFailAlert: Bool = true,
                                   modelType: T.Type,
                                   successCallback:@escaping RequestModelSuccessCallBack<T>,
                                   failureCallback: RequestFailureCallback? = nil) -> Cancellable? {

    return netWorkRequest(target, needShowFailAlert: needShowFailAlert, successCallback: { (responseModel) in

        let jsonStr = String(responseModel.data)
        if let model = T.deserialize(from:jsonStr) {
            successCallback(model, responseModel)
        } else {
            if responseModel.code == 200 {
                successCallback(nil, responseModel)
            } else {
                
                if(target.path == "/api/app/my/order/confirmedReceive" || target.path == "/api/app/my/withdraw/doCash" || target.path == "/api/app/mall/details" || target.path == "/api/app/my/bankCard/getRealnameInfo" || target.path == "/api/app/courseLive/wonderfulReviewDetails" || target.path == "/api/app/index/doSearch"){
                  
                    successCallback(responseModel as? T, responseModel)
            }
               
             
              
                
                
            }
        }
    }, failureCallback: failureCallback)
}
/// 网络请求，当模型为[dict]类型
/// - Parameters:
///   - target: 接口
///   - showFailAlert: 是否显示网络请求失败的弹框
///   - modelType: 模型
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
@discardableResult
func kNetWorkRequest<T: HandyJSON>(_ target: TargetType,
                                   needShowFailAlert: Bool = true,
                                   modelType: [T].Type,
                                   successCallback:@escaping RequestModelsSuccessCallback<T>,
                                   failureCallback: RequestFailureCallback? = nil) -> Cancellable? {
    return netWorkRequest(target, needShowFailAlert: needShowFailAlert, successCallback: { (responseModel) in

        let jsonArrayString: String = String(responseModel.data)
        if let models = ([T].deserialize(from: jsonArrayString) as? [T]) {
            successCallback(models, responseModel)
        } else {
         //   successCallback([], responseModel)
//            errorHandler(code: responseModel.code, message: "JSON 解析失败", needShowFailAlert: needShowFailAlert, failure: failureCallback)
          
               if(target.path == "/api/app/index/doSearch"){
                 
                successCallback([], responseModel)
           }
            
            
        }
    }, failureCallback: failureCallback)
}


/// 网络请求的基础方法
/// - Parameters:
///   - target: 接口
///   - needShowFailAlert: 是否显示网络请求失败的弹框
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
private func netWorkRequest(_ target: TargetType,
                                needShowFailAlert: Bool = true,
                                successCallback:@escaping RequestFailureCallback,
                                failureCallback: RequestFailureCallback? = nil) -> Cancellable? {

//    if !UIDevice.isNetworkConnect {
//
//        errorHandler(code: 500, message: "网络似乎出现了问题".local, needShowFailAlert: needShowFailAlert, target.path, failure: failureCallback)
//       // let respModel = ResponseModel()
//       // successCallback(respModel)
//        return nil
//    }
    return kProvider.request(MultiTarget(target)) { (result) in
        
        
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSON(data: response.data)
                  debugPrint("====",target.path)
                 print("返回的结果是11: \(jsonData)")
                let respModel = ResponseModel()

                if !validateResponse(response: jsonData.dictionary, needShowFailAlert: needShowFailAlert, target.path, failure: failureCallback) {

                    if let code = jsonData.dictionaryValue["code"]?.rawValue as? Int {

                        respModel.code = code
                    }
                    if let msg = jsonData.dictionaryValue["message"]?.rawValue as? String {
                        
                        respModel.message = msg
                    }
                
                    if let data = jsonData.dictionaryValue["data"]?.rawValue as? Dictionary<String, Any> {
                        let x = try? JSONSerialization.data(withJSONObject: data, options: [])
                        let str = String(data: x!, encoding: .utf8)
                        
                        respModel.data = str!
                    }
                    
                    
           
                    successCallback(respModel)
                    return
                }
                /// 这里的 500的code码 需要根据具体业务来设置
                respModel.code = jsonData[codeKey].int ?? 500
                respModel.message = jsonData[messageKey].stringValue

//                    #if DEBUG
//                    respModel.data = jsonData[dataKey].rawString() ?? ""
//                    successCallback(respModel)
//                    #endif

                if respModel.code == successCode {
                    var dataJSON: String? = jsonData[dataKey].rawString()
                    dataJSON = dataJSON?.replacingOccurrences(of: "\n", with: "")
                    respModel.data = dataJSON ?? ""
                    successCallback(respModel)
                } else {
                    errorHandler(code: respModel.code, message: respModel.message, needShowFailAlert: needShowFailAlert, target.path, failure: failureCallback)
                    successCallback(respModel)
                    return
                }

            } catch {
                // code = 10000 代表JSON解析失败  这里根据具体业务来自定义
                errorHandler(code:10000, message: String(data: response.data, encoding: String.Encoding.utf8)!, needShowFailAlert: needShowFailAlert, target.path, failure: failureCallback)
                let respModel = ResponseModel()
                successCallback(respModel)
            }
        case let .failure(error as NSError):
            errorHandler(code: error.code, message: "网络连接失败", needShowFailAlert: needShowFailAlert, target.path, failure: failureCallback)
           // let respModel = ResponseModel()
           //successCallback(respModel)
        }
    }
}

/// 预判断后台返回的数据有效性 如通过Code码来确定数据完整性等  根据具体的业务情况来判断  有需要自己可以打开注释
/// - Parameters:
///   - response: 后台返回的数据
///   - showFailAlet: 是否显示失败的弹框
///   - failure: 失败的回调
/// - Returns: 数据是否有效
private func validateResponse(response: [String: JSON]?, needShowFailAlert: Bool,_ path :String , failure: RequestFailureCallback?) -> Bool {

    var errorMessage: String = ""
    if response != nil {
        if !(response?.keys.contains(codeKey))! {
            errorMessage = "返回值不匹配：缺少状态码".local
        } else if response![codeKey]!.int == 500 {
            errorMessage = "服务器开小差了".local
        }
        if let errorMsg = response?["message"]?.rawValue {
            errorMessage = errorMsg as! String
        }
    } else {
        errorMessage = "服务器数据开小差了".local
    }
    if !errorMessage.isEmpty {
        var code: Int = 500
        if let codeNum = response?[codeKey]?.int {
            code = codeNum
        }
        if let status = response?["status"]?.int {
            code = status
        }

        if let msg = response?[messageKey]?.stringValue {
            errorMessage = msg
        }
        errorHandler(code: code, message: errorMessage, needShowFailAlert: needShowFailAlert, path, failure: failure)
        return false
    }
    return true
}

private func errorHandler(code: Int, message: String, needShowFailAlert: Bool, _ path :String?,failure: RequestFailureCallback?) {
    print("发生错误：\(String(describing: path))\(code)--\(message)")
    let model = ResponseModel()
    model.code = code
    model.message = message
    if needShowFailAlert {
        // 弹框
//        let currentVC = UIViewController.getTopViewController()
//        currentVC?.showAlert(title: "发生错误", message: message)
//        SZPLog.e("弹出错误信息弹框\(message)")
        
        DispatchQueue.main.async {
            
            if(message != "你没有购买图纸查看权限" && message != "NOT_VIP"){
                
//                SZPHudExtension.szp_showPlainText(message:message)
            }
//              SZPAutoProgressHUD.hideHud()
            
            if(message == "您要查询的动态不存在或已删除"){
                
                let currentVC = UIViewController.getTopViewController()
                currentVC?.navigationController?.popViewController()
                
            }
           
        }
     
//        SZPHudExtension.szp_showPlainText(message: message)
       //未登录错误
        if(code == 401){
            AppManager.pushLoginVC()
        }
       
        
    }
    failure?(model)
}

private let myEndpointClosure = {(target: TargetType) -> Endpoint in

    /// 这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
     */
//    let additionalParameters = ["APP-Token":"888888"]
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }
    /*
     👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */

    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30 // 每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    // 针对于某个具体的业务模块来做接口配置
    if let apiTarget = target as? SZPAPI {
        switch apiTarget {
        case .loginByPwd:
            return endpoint
        case .loginByCode:
            requestTimeOut = 5
            return endpoint
        default:
            return endpoint
        }
    }
    return endpoint
}

/// 检测用户是否登录
@discardableResult
func kCheckoutLoginState() -> Bool {
    var islogin: Bool = false
    if let token = kUserDefaultRead(kdefaultToken), !token.isEmpty {
        print("当前用户token是：\(token)")
        islogin = true
    }
    return islogin
}

/// 网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in

    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = requestTimeOut
        
        
 
        
        if let requestData = request.httpBody {
            print("请求的url：\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        } else {
            print("请求的url：\(request.url!)" + "\(String(describing: request.httpMethod))")
        }
        if let header = request.allHTTPHeaderFields {
            print("请求头内容\(header)")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

// FIXME: - 这里需要 设置ssl证书验证
// 用Moya默认的Manager还是Alamofire的Manager看实际需求。HTTPS就要手动实现Manager了
private let kSession : Session = {
//   // 证书数据
//    func certificate() -> SecCertificate? {
//        let filePath = Bundle.main.path(forResource: "存在Xcode中证书的文件名", ofType: "cer")
//        if filePath == nil {
//            return nil
//        }
//        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath ?? ""))
//        let certificate = SecCertificateCreateWithData(nil, (data as CFData))!
//        return certificate
//    }
//
//   guard let certificate = certificate() else {
//       return Session()
//   }
//   let trusPolicy = PinnedCertificatesTrustEvaluator(certificates: [certificate], acceptSelfSignedCertificates: false, performDefaultValidation: true, validateHost: true)
    let certificate = AlamofireExtension(Bundle.main).certificates
    let trusPolicy = PinnedCertificatesTrustEvaluator(certificates: certificate, acceptSelfSignedCertificates: false, performDefaultValidation: true, validateHost: true)
   let trustManager = ServerTrustManager(evaluators: ["api.ycswxj.com" : trusPolicy])
   let configuration = URLSessionConfiguration.af.default
   return Session(configuration: configuration, serverTrustManager: trustManager)
}()

/// 网络请求发送的核心初始化方法，创建网络请求对象
private let kProvider = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)
//private let kProvider = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, session: kSession, plugins: [networkPlugin], trackInflights: false)

/// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
private let networkPlugin = NetworkActivityPlugin.init { (changeType, _ ) in
    print("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    switch changeType {
    case .began:
        print("开始请求网络")
    case .ended:
        print("结束")
    }
}

class ResponseModel {
    var code: Int = 0
    var message: String = ""

    /// 这里的data用String类型 保存response.data
    var data: String = ""

    /// 分页的游标 根据具体的业务选择是否添加这个属性
    var cursor: String = ""
}

/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用计算型属性是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
extension UIDevice {
   static var isNetworkConnect: Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true // 无返回就默认网络已连接
    }
}
