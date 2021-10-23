//
//  MALAutoProgressHUD.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit


class MALAutoProgressHUD: NSObject {

    static var hud: MBProgressHUD = {
       
        let hud = MBProgressHUD(view: kWindow ?? UIWindow.init())
        kWindow?.addSubview(hud)
        return hud
    }()

    class func showAutoHud(_ msg: String) {
        DispatchQueue.main.async {
            hud.label.text = msg
            hud.mode = .text
            hud.label.textColor = .darkGray
            hud.superview?.bringSubviewToFront(hud)
            hud.show(animated: true)
            hud.hide(animated: true, afterDelay: 2.0)
        }
    }

    class func showHud(_ msg: String = "") {
        DispatchQueue.main.async {
            hud.label.text = msg
            hud.mode = .indeterminate
            hud.label.textColor = .darkGray
            hud.superview?.bringSubviewToFront(hud)
            hud.show(animated: true)
        }
    }

    class func hideHud() {
        DispatchQueue.main.async {
            hud.hide(animated: true)
        }
    }

}
