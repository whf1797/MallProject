//
//  MALPredefine.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

// 宏定义
import UIKit

import SnapKit
import SwifterSwift
import Kingfisher
import SwiftyJSON
import HandyJSON

enum GradientType : Int {
    case topToBottom = 0 //从上到小
    case leftToRight = 1 //从左到右
    case upleftTolowRight = 2 //左上到右下
    case uprightTolowLeft = 3
}
//视频
let productsId  = "com.huimi.shunxiu.mantenance.home.ios"
//图片
let productsId_diagram = "com.huimi.shunxiu.diagram"
//视频包
let productsId_video = "com.huimi.shunxiu.videopackage"
//
let productsId_Live = "com.huimi.shunxiu.Live"

func isVip()-> Bool{
    
    let vipLevel =  kUserDefaultRead(kdefaultUserVipLevel)
      
    if(vipLevel == "2"  || vipLevel == "4"){
        
    return true
    }
    
    return false
    
}

func getTextHeigh(_ textStr :String, _ font : UIFont,_ width : CGFloat) -> CGFloat{

       let normalText : NSString = textStr as NSString
       let size = CGSize(width: width, height:1000)  //CGSizeMake(width,1000)
       let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
       let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
       return stringSize.height

   }



let kAppStorePhone = "18203311714";


let appdelegate = UIApplication.shared.delegate as! AppDelegate


/// 根控制器
 let kWindow: UIWindow? = {
    
    if #available(iOS 13.0, *){
        
     
        
      return  UIApplication.shared.connectedScenes
                   .filter { $0.activationState == .foregroundActive }
                   .compactMap { $0 as? UIWindowScene }.first?.windows
                   .filter { $0.isKeyWindow }.first
        
   
    }else{
      
      return  appdelegate.window
        
    }
    
    
}()

var kScreenWidth = UIScreen.main.bounds.width
var kScreenHeight = UIScreen.main.bounds.height


let isiPhoneX = ((UIScreen.main.bounds.height - 812) >= 0 ? true : false)


let UI_IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let UI_IS_IPHONE4 = UI_IS_IPHONE && UIScreen.main.bounds.size.height < 568.0
let UI_IS_IPHONE5 = UI_IS_IPHONE && UIScreen.main.bounds.size.height == 568.0 || UIScreen.main.bounds.size.width == 568.0
let UI_IS_IPHONE6 = UI_IS_IPHONE && UIScreen.main.bounds.size.height == 667.0 || UIScreen.main.bounds.size.width == 667.0
let UI_IS_IPHONE6PLUS = UI_IS_IPHONE && UIScreen.main.bounds.size.height == 736.0 || UIScreen.main.bounds.size.width == 736.0

let Device_Is_iPhoneX = UI_IS_IPHONE && UIScreen.main.bounds.size.height == 2436/3 || UIScreen.main.bounds.size.width == 2436/3
let Device_Is_iPhoneXr = UI_IS_IPHONE && UIScreen.main.bounds.size.height ==  1792/2 || UIScreen.main.bounds.size.width ==  1792/2
let Device_Is_iPhoneXs = UI_IS_IPHONE && UIScreen.main.bounds.size.height ==  2436/3 || UIScreen.main.bounds.size.width ==  2436/3
let Device_Is_iPhoneXs_Max = UI_IS_IPHONE && UIScreen.main.bounds.size.height ==  896.0 || UIScreen.main.bounds.size.width ==  896.0

let Device_Is_iPhoneX_pro_Max = UI_IS_IPHONE && UIScreen.main.bounds.size.height ==  926.0 || UIScreen.main.bounds.size.width ==  926.0

let isIphoneX = (Device_Is_iPhoneX || Device_Is_iPhoneXr || Device_Is_iPhoneXs || Device_Is_iPhoneXs_Max)


/// statusBar高度
let kStatusBarHeight = (!UIApplication.shared.isStatusBarHidden ? UIApplication.shared.statusBarFrame.size.height : isiPhoneX ? 44.0 : 20.0)
let kNavigationBarHeight = 44 + kStatusBarHeight
let kTabBarHeight = 49 + kBottomSafeAreaHeight
/// 安全区域下面的高度
let kBottomSafeAreaHeight = isiPhoneX ? CGFloat(34) : 0

/// 以屏幕宽度为固定比例关系，来计算对应的值
let scaleW = kScreenWidth / 375.0

func MAL_Value(_ value: CGFloat) -> CGFloat {

    return CGFloat(Int((value)/375.0 * kScreenWidth))
}
func MAL_ValueH(_ value: CGFloat) -> CGFloat {
    return CGFloat(value) / (isiPhoneX ? 1624.0 : 1334.0) * kScreenHeight
}


func MAL_RGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha:CGFloat? = 1.0 ) -> UIColor {
    return UIColor.init(red: red, green: green, blue: blue, alpha: alpha ?? 1.0)
}

func MAL_Price(_ price:String, _ showDot:Bool = false) -> String {
    if price.isEmpty {
        return "￥"
    }
    if showDot {
        let doublePrice = Double(price)
        return String(format: "￥%.2f", doublePrice ?? 0.0)
    } else {
        
        let doublePrice = Double(price)
        let subPrice  =  String(format: "%.2f", doublePrice ?? 0.0)
        
        if subPrice.hasSuffix(".00") { // true
           
            guard let count = Double(subPrice) else { return "0" };
          
            return String(format: "￥%d",Int(count))
           
        }else{
            
            return String(format: "￥%@", price)
            
        }
        
       
    }
    
    
}

func MAL_ImageWithFile(_ name:String) -> UIImage {

    if !name.isEmpty {

        let path = Bundle.main.path(forResource: name, ofType: nil)
        return UIImage.init(contentsOfFile: path!)!
    } else {
        return UIImage.init()
    }
}

func MAL_ImageNamed(_ name:String) -> UIImage {

    if !name.isEmpty {
        return UIImage.init(named: name) ?? UIImage.init()
    } else {
        return UIImage.init()
    }
}

/// 设置View 圆角和边框
func MAL_ViewBorderRadius(_ view:UIView, _ radius: CGFloat, _ width: CGFloat? = 0.0, _ color: UIColor? = UIColor.white) {

    view.layer.masksToBounds = true
    view.layer.cornerRadius = radius
    view.layer.borderWidth = width ?? 0.0
    view.layer.borderColor = color?.cgColor ?? UIColor.white.cgColor

}

func MAL_ViewBorderRadiusBounds(_ view:UIView, _ radius: CGFloat, _ width: CGFloat? = 0.0, _ color: UIColor? = UIColor.white) {

    view.layer.cornerRadius = radius
    view.layer.borderWidth = width ?? 0.0
    view.layer.borderColor = color?.cgColor ?? UIColor.white.cgColor

}

func kUserDefaultRead(_ key: String) -> String? {
    return UserDefaults.standard.string(forKey: key)
}
func kUserDefaultWrite(_ key: String, _ value: Any) {
    return UserDefaults.standard.setValue(value, forKey: key)
}
func kUserDefaultRemove(_ key: String) {
    return UserDefaults.standard.removeObject(forKey: key)
}

func setShadow(view:UIView,width:CGFloat,_ bColor:UIColor = UIColor.AppColor.noticeShadowColor,
               sColor:UIColor,_ offset:CGSize = CGSize.init(width: 0, height: 5),opacity:Float,radius:CGFloat) {
        //设置视图边框宽度
        view.layer.borderWidth = width
        //设置边框颜色
        view.layer.borderColor = bColor.cgColor
        //设置边框圆角
        view.layer.cornerRadius = radius
        //设置阴影颜色
        view.layer.shadowColor = sColor.cgColor
        //设置透明度
        view.layer.shadowOpacity = opacity
        //设置阴影半径
        view.layer.shadowRadius = radius
        //设置阴影偏移量
        view.layer.shadowOffset = offset
    }


func buttonImage(gradientType:GradientType, andFrame size: CGSize, andType type: String?) -> UIImage? {
    var ar: [AnyHashable] = []
    
    let color1 =  UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.6).cgColor
    ar.append(color1)
    let color2 =  UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.8).cgColor
    ar.append(color2)
       let color3 =   UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1).cgColor
    ar.append(color3)
    
    UIGraphicsBeginImageContextWithOptions(size, true, 1)
    let context = UIGraphicsGetCurrentContext()
    context?.saveGState()
    let colorSpace = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1).cgColor.colorSpace
    var gradient: CGGradient? = nil
     
    gradient = CGGradient(colorsSpace: colorSpace, colors: ar as CFArray, locations: nil)
    let start: CGPoint
    let end: CGPoint
 
    
    switch gradientType {
    case GradientType.topToBottom:
        end = CGPoint(x: 0.0, y: size.height)
          start = CGPoint(x: 0.0, y: 0.0)
       
        case GradientType.leftToRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: 0.0)
    case GradientType.upleftTolowRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: size.height)
    case GradientType.uprightTolowLeft:
            start = CGPoint(x: size.width, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
       
    }
    
    context?.drawLinearGradient(gradient ?? "" as! CGGradient, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
    let image = UIGraphicsGetImageFromCurrentImageContext()
    context?.restoreGState()
    UIGraphicsEndImageContext()
    return image

}

extension String {

    /// 时间字符串转换
    func mal_convertDateString(_ formatter: String = "MM-dd HH:mm") -> String {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = formatter
        let dateStr = dateFormatter.string(from: date ?? Date.init())
        return dateStr
      
        
    }
}
