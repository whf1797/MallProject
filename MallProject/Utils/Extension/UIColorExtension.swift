//
//  UIColorExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

class UIColorExtension: NSObject {

}

// MARK: 通过16进制初始化UIColor
public extension UIColor {

    ///
    convenience init(numberColor: Int, alpha: CGFloat = 1.0) {
        self.init(hexColor: String(numberColor, radix: 16), alpha: alpha)
    }


    ///
    convenience init(hexColor: String, alpha: CGFloat = 1.0) {
        var hex = hexColor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        if hex.hasPrefix("0x") || hex.hasPrefix(("0X")) {
            hex.removeSubrange((hex.startIndex ..< hex.index(hex.startIndex, offsetBy: 2)))
        }

        guard let hexNum = Int(hex, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
            return
        }

        switch hex.count {
        case 3:
            self.init(red: CGFloat(((hexNum & 0xF00) >> 8).duplicate4bits) / 255.0,
                      green: CGFloat(((hexNum & 0x0F0) >> 4).duplicate4bits) / 255.0,
                      blue: CGFloat((hexNum & 0x00F).duplicate4bits) / 255.0,
                      alpha: alpha)
        case 6:
            self.init(red: CGFloat((hexNum & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((hexNum & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat((hexNum & 0x0000FF) >> 0) / 255.0,
                      alpha: alpha)
        default:
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }

}

public extension UIColor {
    enum AppColor {
        
        /// 主题色 #6AC9F1
        public static let main = UIColor.init(hexString: "#dfb367")!
        /// 主题色 #6AC9F1, alpha: 0.4
        public static let mainLightColor = UIColor.init(hexColor: "#6AC9F1", alpha: 0.2)
        /// e2f5fd
        public static let mallEvalNormalBgColor = UIColor.init(hexColor: "#e2f5fd")

        ///  #C5CACB
        public static let loginTipTextColor = UIColor.init(hexString: "#C5CACB")!

        /// vip按钮背景色 #2A2E3F
        public static let vipBgColor = UIColor.init(hexString: "#2A2E3F")!
        /// vip按钮背景色 #ECD185
        public static let vipBgColor1 = UIColor.init(hexString: "#ECD185")!

        /// vip按钮文字色 #E6CB95
        public static let vipTextColor = UIColor.init(hexString: "#E6CB95")!
        /// vip按钮文字色 #FCE9C6
        public static let vipTextColor1 = UIColor.init(hexString: "#FCE9C6")!

        /// 弹框背景色 #000000, alpha: 0.04
        public static let noticeShadowColor = UIColor.init(hexColor: "#000000", alpha: 0.04)
        /// 直播暂停遮罩背景色 #000000, alpha: 0.59
        public static let videoPluseShadowColor = UIColor.init(hexColor: "#000000", alpha: 0.59)
        /// 试看结束遮罩颜色 #000000, alpha: 0.8
        public static let videoTryShadowColor = UIColor.init(hexColor: "#000000", alpha: 0.8)
        /// 弹框背景色 #000000, alpha: 0.3
        public static let alertBackgroundColor = UIColor.init(hexColor: "#333333", alpha: 0.3)
        /// #AAAAAA
        public static let textColorAAA = UIColor.init(hexColor: "#AAAAAA")
        /// 试看 #DDA437
        public static let textColorTrySee = UIColor.init(hexColor: "#DDA437")
        /// 试看 背景色 #DDA437, alpha: 0.2
        public static let backgroundColorTrySee = UIColor.init(hexColor: "#DDA437", alpha: 0.2)
        
        public static let backgroundColorNormal = UIColor.init(hexColor: "#f2f2f2", alpha: 1)

        /// 字体颜色 #000000 黑色
        public static let titleColorNormal = UIColor.init(hexString: "#000000")!

        /// #CBD0D2
        public static let textViewPlaceholderColor = UIColor.init(hexColor: "#CBD0D2")
        /// 字体颜色 #666666
        public static let titleColorLight = UIColor.init(hexString: "#666666")!
        /// 字体颜色 #333333
        public static let titleColorLightBlack = UIColor.init(hexString: "#333333")!

        /// 搜索框背景色 #F5F9FA
        public static let searchBgColor =  UIColor.init(hexString: "#F5F9FA")!
        
        /// EAECEE
        public static let categoryDetailBgColor = UIColor.init(hexString: "#EAECEE")!

        /// #999999
        public static let categoryDetailHeaderLineBgColor = UIColor.init(hexString: "#999999")!
        /// #999999
        public static let lightGrayColor = UIColor.init(hexString: "#999999")!
        /// 当前价格颜色 #FF7500
        public static let homeCurrentPriceColor = UIColor.init(hexString: "#df0000")!
        /// #CCCCCC
        public static let borderLineColor = UIColor.init(hexString: "#CCCCCC")!
        /// #F5F9FA
        public static let textViewBgColor = UIColor.init(hexString: "#F5F9FA")!
        /// #DDE0E2
        public static let buttonSelectNoColor = UIColor.init(hexString: "#DDE0E2")!
        /// cell 中的 line 颜色 #E8EBF2
        public static let cellLineColor = UIColor.init(hexString: "#c8cBc8")!

        /// #495068 退货售后顶部的背景色
        public static let afterSaleBgColor = UIColor.init(hexString: "#495068")!
        /// #FCD983
        public static let shareRulesBgColor = UIColor.init(hexString: "#FCD983")!
        /// #CC9B4F
        public static let shareRulesTextColor = UIColor.init(hexString: "#CC9B4F")!
    }
}
private extension Int {
    var duplicate4bits: Int {
        return self << 4 + self
    }
}
