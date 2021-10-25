//
//  MALFoundationExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

/// app 所使用的语言，暂时只支持 中英文。非中文情况下都当作英文
enum AppLanguageType: String {
    /// 英文, 包括其它非中文
    case enType
    /// 中文, 包括简体/繁体
    case zhType
    //    /// 不关注语言类型, 固化功能
    //    case stable
}


import UIKit

class MALFoundationExtension: NSObject {

}

// MARK: String extension
extension String {

    /**
     `国际化`
     */
    var local: String {
//        return NSLocalizedString(self, comment: "Planetoid")
        return MALLocalizationTool.shared.valueWithKey(key: self)
    }

    static var currentLanguage: String {
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return "zh-Hans"
        }
        return lang
    }

    /// 手机号码验证
    var isTelNumber: Bool {
        let mobile = "^1\\d{10}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        if regextestmobile.evaluate(with: self) {
            return true
        }
        return false
    }

    /// 密码验证
    var isPassword: Bool {
        let psd = "^.{6,20}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", psd)
        if regextestmobile.evaluate(with: self) {
            return true
        }
        return false
    }

    /// 验证码验证
    var isVerifyCode: Bool {
        let code = "^[0-9]{4,6}"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", code)
        if regextestmobile.evaluate(with: self) {
            return true
        }
        return false
    }

    /// 邮箱验证
    var isEmail: Bool {
        let email = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", email)
        if regextestmobile.evaluate(with: self) {
            return true
        }
        return false
    }

    var isTryNumber: Bool {
        let email = "^(0|[1-9][0-9]*)$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", email)
        if regextestmobile.evaluate(with: self) {
            return true
        }
        return false
    }

    static func getCurrentLanguage() -> AppLanguageType {
        let languages = Locale.preferredLanguages
        let firstLanguage = languages[0]

        if firstLanguage.hasPrefix("zh") {
            return .zhType
        } else {
            return .enType
        }
    }

    func size(with width: CGFloat, font:UIFont) -> CGSize {
        let wrapperSize = CGSize(width: width, height: 1000)
        let option = NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesFontLeading)
        let size = (self as NSString).boundingRect(with: wrapperSize, options: option, attributes: [NSAttributedString.Key.font:font], context: nil).size
        let textWidth = ceil(Double(size.width))
        let textHeight = ceil(Double(size.height))
        return CGSize(width: textWidth, height: textHeight)
    }

    func size(withWidth width: CGFloat, font: UIFont) -> CGSize {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
    
}

extension UIFont {

    /// 标题或者价格使用的字号（偏粗体）：Helvetica
    static func szpHelveticaFont(_ size: CGFloat = 16) -> UIFont {
        let font = UIFont(name: "Helvetica", size: size * scaleW)
        return font!
    }
    /// 苹果普通字体
    static func szpAppleNormalFont(_ size: CGFloat = 16) -> UIFont {
        return UIFont.systemFont(ofSize: size * scaleW)
    }

    /// 苹果粗体
    static func szpAppleBoldFont (_ size: CGFloat = 18) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size * scaleW)
    }
}

extension String {


    /// 根据字符串高度，获取宽度
    /// - Parameters:
    ///   - height: 高度固定
    ///   - font: 字体
    /// - Returns: 返回字符串宽度
    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }


    /// 根据字符串宽度，获取字符串高度
    /// - Parameters:
    ///   - width: 宽度固定
    ///   - font: 字体
    /// - Returns: 返回高度
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

}
