//
//  MALButtonExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

class MALButtonExtension: UIButton {

    typealias KCountDownBlock = (_ btn: UIButton) -> Void
    var countDownBlock: KCountDownBlock!


    /// 倒计时
    /// - Parameters:
    ///   - timeLine: 倒计时时间
    ///   - title: 正常是显示问题
    ///   - countDownTitle: 倒计时时显示的文字（不包含秒）
    ///   - isInteraction: 是否希望倒计时时可交互
    ///   - countDownBlock: 倒计时结束时的Block
    func countDownWithTime(timeLine: NSInteger, title: String, countDownTitle: String, isInteraction: Bool, countdownBlock:@escaping KCountDownBlock) {

        let countDownTitleColor = UIColor.init(hexString: "#DDE0E2")
        var timeout = timeLine

        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global(qos: .default))
        timer.schedule(wallDeadline: .now(), repeating: 1.0)
        timer.setEventHandler(handler: { [weak self] in

            if timeout <= 0 {
                timer.cancel()

                DispatchQueue.main.async {
                    countdownBlock(self!)
                    self?.isUserInteractionEnabled = true
                    self?.setTitle(title, for: .normal)
                    self?.setTitleColor(UIColor.init(hexString: "#6AC9F1"), for: .normal)
                }

            } else {

                var strTime = String(format: "%.2d", Int(timeout))
                if timeout < 10 {
                    strTime = String(format: "%.1d", Int(timeout))
                }
                DispatchQueue.main.async {
                    let titleString = String(format: "%@ s %@", strTime, countDownTitle)
                    self?.setTitle(titleString, for: .normal)
                    self?.setTitleColor(countDownTitleColor, for: .normal)
                    self?.isUserInteractionEnabled = isInteraction
                }
                timeout -= 1
            }
        })
        timer.resume()
    }

}

extension UIButton {

    /// 设置内容距离左右两端的边距（默认图片左，文字右）
    func setContentSpace(_ space: CGFloat) {
        if space != 0 {
            self.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: space, bottom: 0, right: space)
        }
    }

    /// 设置图片距离右侧的距离（有可能盖住文字，默认图片左，文字右）
    func setImageSpace(_ space: CGFloat = 0) {

        let itemSpace = space + (self.titleLabel?.intrinsicContentSize.width ?? 0)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: itemSpace, bottom: 0, right: itemSpace)
    }

    /// 设置文字与图片的间距（默认图片左，文字右）
    func setTitleSpace(_ space: CGFloat) {
        if space != 0 {
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: space, bottom: 0, right: -space)
        }
    }

    /// 设置图片距离右侧的距离，文字距离图片的距离（默认图片左，文字右）
    /// - Parameters:
    ///   - contentSpace: 图片+文字与两端的距离
    ///   - titleSpace: 图片与文字的距离
    func setContentAndTitleSpace(_ contentSpace:CGFloat = 0, _ titleSpace:CGFloat = 0) {
        self.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: contentSpace, bottom: 0, right: contentSpace)
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: titleSpace, bottom: 0, right: titleSpace)
    }

    /// 图片居右，文字左
    /// - Parameters:
    ///   - imageSpace: 图片距离右侧的距离
    ///   - titleSpace: 文字距离左侧的距离
    func setImageAndTitleSpace(_ imageSpace: CGFloat = 0, _ titleSpace:CGFloat = 0) {

        let itemImageSpace = imageSpace + (self.titleLabel?.intrinsicContentSize.width ?? 0)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: itemImageSpace, bottom: 0, right: -itemImageSpace)

        let itemTitleSpace = titleSpace + (self.imageView?.intrinsicContentSize.width ?? 0)
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -itemTitleSpace, bottom: 0, right: itemTitleSpace)
    }

}

extension UIButton {

    /// 提供多个运行时的key
    struct RuntimeKey {
        static let buttonKey = UnsafeRawPointer.init(bitPattern: "BTNKey".hashValue)
    }
    
    /// 点击区域：需要扩充的边距: UIEdgeInsets 相应的负数为扩大，正数为缩小
    var hitTestEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.buttonKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.buttonKey!) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
    }
    
    /// 是否响应
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (hitTestEdgeInsets! == UIEdgeInsets.zero) || !isEnabled || isHidden {
            return super.point(inside: point, with: event)
        } else {
            let expandArea = self.bounds.inset(by: hitTestEdgeInsets!)
            return expandArea.contains(point)
        }
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
}
