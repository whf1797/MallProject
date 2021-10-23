//
//  UIViewExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit


extension UIView {

    class var scale: CGFloat { return UIScreen.main.scale }

    class var mainBounds: CGRect  { return UIScreen.main.bounds }

    class var width: CGFloat { return mainBounds.width }

    class var height: CGFloat { return mainBounds.height}

    var width: CGFloat {

        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }

    var height: CGFloat {

        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }

    var size: CGSize {

        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }

    var origin: CGPoint {

        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }

    //    var x: CGFloat {
    //
    //        get {
    //            return frame.minX
    //        }
    //        set {
    //            frame.origin = CGPoint(x: newValue, y: y)
    //        }
    //    }
    //
    //    var y: CGFloat {
    //
    //        get {
    //            return frame.minY
    //        }
    //        set {
    //            frame.origin = CGPoint(x: x, y: newValue)
    //        }
    //    }

    var centerX: CGFloat {

        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }

    var centerY: CGFloat {

        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }

    var left: CGFloat {
        get {
            return frame.minX
        }
        set {
            frame.origin.x = newValue
        }
    }

    var right: CGFloat {

        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - width
        }
    }


    var top: CGFloat {

        get {
            return frame.minY
        }
        set {
            frame.origin.y = newValue
        }
    }


    var bottom: CGFloat {

        get {
            return frame.maxY
        }
        set {
            frame.origin.y = newValue - height
        }
    }
}

extension UIView {

    var cornerRadius: CGFloat {

        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    func radiusView(_ radius: CGFloat) {

        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }

    func roundView() {
        radiusView(frame.height / 2)
    }

    func roundCorner(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}

extension UIView {

    /// UIView设置任意某个角为圆角（摘自SwifterSwift，设置[.bottomLeft, .topRight]即可。PS：被设置的View要设置Frame。）
    func szpRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

}
