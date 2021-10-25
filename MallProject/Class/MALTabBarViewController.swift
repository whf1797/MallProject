//
//  MALTabBarViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/6.
//

import UIKit

class MALTabBarViewController: UITabBarController {
    
    deinit {
        
        debugPrint("SZPTabBarController销毁")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeVC = MALHomeViewController()
        let homeItem = UITabBarItem.init(title: "首页", image: MAL_ImageNamed("homeUnSel"), selectedImage: MAL_ImageNamed("homeSel"))
        homeVC.tabBarItem = homeItem

        let categoryVC = MALMallCartViewController()
        let categoryItem = UITabBarItem.init(title: "购物车", image: MAL_ImageNamed("carUnSel"), selectedImage: MAL_ImageNamed("carSel"))
        categoryVC.tabBarItem = categoryItem


       

        let myVC = MALMyViewController()
        let myItem = UITabBarItem.init(title: "我的", image: MAL_ImageNamed("mineUnSel"), selectedImage: MAL_ImageNamed("mineSel"))
        myVC.tabBarItem = myItem
        self.tabBar.tintColor = UIColor.AppColor.main
        self.viewControllers = [homeVC, categoryVC, myVC]
    }
    


}
