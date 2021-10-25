//
//  SZPHudExtension.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/4/22.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit


enum SZPHUDLoadingProgressStyle {
    case progressStyleDeterminate // 开扇形加载进度
    case determinateHorizontalBar // 横条加载进度
    case styleAnnularDeterminate    // 环形加载进度
    case other // 其他
}

class SZPHudExtension: MBProgressHUD {

    class func szp_showText(text: String, view: UIView) {

    }
    /// 快速显示一个提示信息
    class func szp_showPlainText(message:String, timeAfter:TimeInterval? = 1.0, view:UIView? = kWindow) {

        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.label.numberOfLines = 0
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: timeAfter!)
    }
    /// 显示带有自定义icon图片的消息
    class func szp_showIcon(icon:UIImage, message:String, timeAfter:TimeInterval? = 1.0, view:UIView? = kWindow) {

        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .customView
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        hud.label.text = message
        hud.customView = UIImageView.init(image: icon)
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: timeAfter!)
    }
    /// 自定义View的方法
    class func szp_showCustomView(customerView:UIView, message:String?, timeAfter:TimeInterval? = 1.0, view:UIView? = kWindow) {

        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .customView
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        if !(message!.isEmpty) {
            hud.label.text = message
        }
        hud.customView = customerView
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: timeAfter!)
    }
    ///  显示菊花加载状态
    class func szp_showActivityLoading(style:SZPHUDLoadingProgressStyle? = .other, message:String?, timeAfter:TimeInterval? = 1.0, view:UIView? = kWindow) {

        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        switch style {
        case .progressStyleDeterminate:
            hud.mode = .determinate
        case .determinateHorizontalBar:
            hud.mode = .determinateHorizontalBar
        case .styleAnnularDeterminate:
            hud.mode = .annularDeterminate
        default:
            hud.mode = .indeterminate
        }
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        if !(message!.isEmpty) {
            hud.label.text = message
        }
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: timeAfter!)
    }


    /// 隐藏HUD
    class func szp_hideHud(_ view:UIView){

        self.hide(for: view, animated: true)
    }



}

