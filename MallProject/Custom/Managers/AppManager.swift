//
//  AppManager.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

private let singleton = AppManager()


class AppManager: NSObject {



    var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }


    class func pushTabbarVC (_ index:Int = 0) {
        
    

        let tabBarVC = MALTabBarViewController()
        tabBarVC.selectedIndex = index
        let rootVC = UINavigationController.init(rootViewController: tabBarVC)
        kWindow?.rootViewController = rootVC
        
        kWindow?.makeKeyAndVisible()
    }

    class func pushLoginVC () {

    }

}


