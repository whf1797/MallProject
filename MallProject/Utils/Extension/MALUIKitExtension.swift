//
//  MALUIKitExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

class MALUIKitExtension: NSObject {

}
extension UIViewController {


    /// 获取当前最顶层的VieController
    /// - Parameter base:
    /// - Returns: description
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    /// 回跳到指定控制器
    /// - Parameter appointVC: 目标控制器
    func szp_popToAppointController(_ appointVC: UIViewController) {
        let popVC = navigationController?.viewControllers.filter({ (item) -> Bool in

            return type(of: item) == type(of: appointVC)
//            return object_getClassName(item) == object_getClassName(appointVC)
        }).first
        guard (popVC != nil) else {
            navigationController?.popViewController()
            return
        }
        navigationController?.popToViewController(popVC!, animated: true)
    }
}
public extension UILabel {

    ///  根据内容，返回 label的宽度
    /// - Parameter height: label的高度
    func requiredWidth(_ height: CGFloat) -> CGFloat {

        let width = text?.widthWithConstrainedHeight(height, font: font)
        return width ?? 0
    }
    ///  根据内容，返回 label的高度
    func requiredHeight(_ width: CGFloat) -> CGFloat {

        let width = text?.heightWithConstrainedWidth(width, font: font)
        return width ?? 0
    }
}

extension UIView {
    //MARK:- 绘制虚线
    /**
     * 绘制虚线
     */
    func drawDottedLine(_ rect: CGRect, _ radius: CGFloat, _ color: UIColor) {
        let layer = CAShapeLayer()
        layer.bounds = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        layer.position = CGPoint(x: rect.midX, y: rect.midY)
        layer.path = UIBezierPath(rect: layer.bounds).cgPath
        layer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: radius).cgPath
        layer.lineWidth = 1/UIScreen.main.scale
        //虚线边框
        layer.lineDashPattern = [NSNumber(value: 5), NSNumber(value: 5)]
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color.cgColor

        self.layer.addSublayer(layer)
    }

    /// 添加顶部通用的阴影
    func szp_addCommonTopShadow() {
        addShadow(ofColor: UIColor.AppColor.noticeShadowColor, radius: MAL_Value(6), offset: CGSize(width: 0, height: MAL_Value(-2)), opacity: 1)
    }

    /// 添加底部的阴影
    func szp_addCommonBottomShadow() {
        addShadow(ofColor: UIColor.AppColor.noticeShadowColor, radius: MAL_Value(4), offset: CGSize.init(width: MAL_Value(2), height: MAL_Value(2)), opacity: 1)
    }
}

extension UITextView {

    // 插入图片
    func insertPicture(_ image:UIImage) {
        // 获取textView的所有文本，转成可变的文本
        let mutableStr = NSMutableAttributedString(attributedString: self.attributedText)

        // 创建图片附件
        let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
        var imgAttachmentString: NSAttributedString
        imgAttachment.image = image

        // 与文字一样大小
        imgAttachment.bounds = CGRect(x: 0, y: -5, width: 20,
                                      height: 20)
        imgAttachmentString = NSAttributedString(attachment: imgAttachment)
        mutableStr.append(imgAttachmentString)
        self.attributedText = mutableStr
    }

    // 添加链接文本（链接为空时则表示普通文本）
    func appendLinkString(string:String, withURLString:String = "") {

        let textColorLink = UIColor.AppColor.main
        let font = UIFont.szpAppleNormalFont(14)
        let normalColor = UIColor.AppColor.lightGrayColor

        // 原来的文本内容
        let attrString:NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.attributedText)

        // 新增的文本内容（使用默认设置的字体样式）
        let attrs = [NSAttributedString.Key.font : font]
        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
        // 判断是否是链接文字
        if withURLString != "" {

            let range:NSRange = NSRange.init(location: 0, length: appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link, value:withURLString, range:range)
            appendString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColorLink, range: range)
            appendString.endEditing()
        } else {
            let range:NSRange = NSRange.init(location: 0, length: appendString.length)
            appendString.addAttribute(NSAttributedString.Key.foregroundColor, value: normalColor, range: range)
        }
        // 合并新的文本
        attrString.append(appendString)

        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 3
        paragraph.alignment = self.textAlignment
        attrString.addAttribute(.paragraphStyle, value: paragraph, range: NSRange.init(location: 0, length: attrString.length))
        // 设置合并后的文本
        self.attributedText = attrString
    }
}

// MARK: - Category
class SZPLabel: UILabel {

    /// UILabel设置内边距
    public var textInsets: UIEdgeInsets = .zero

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    internal init(frame: CGRect, textInsets: UIEdgeInsets) {
        self.textInsets = textInsets
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

/// 设置 UITextField 的 leftView 和 rightView 的 inset
class SZPTextField: UITextField {


    /// 文字与输入框的距离
    override func textRect(forBounds bounds: CGRect) -> CGRect {

        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += MAL_Value(10)
        rect.size.width -= MAL_Value(10)
        return rect
    }

    /// 控制文本的位置
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.origin.x += MAL_Value(10)
        rect.size.width -= MAL_Value(10)
        return rect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {

        var rect = super.rightViewRect(forBounds: bounds)
        // 向左偏移 20
        rect.origin.x -= MAL_Value(20)
        return rect
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)

        // 向右偏移 20
        rect.origin.x = MAL_Value(20)
        return rect
    }
}
