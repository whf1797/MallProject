//
//  SZPUISearchBarExtension.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/4/23.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit

class SZPUISearchBarExtension: UISearchBar {


    /// 背景圆角
    var bgCornerRadius: CGFloat? {
        didSet {

            let subViews = subviews.flatMap { $0.subviews }

            subViews.forEach {
                let clazz = String(describing: type(of: $0))
                switch clazz {
                case "UISearchBarBackground":
                        // Do whatever you want with gray background
                    MAL_ViewBorderRadius($0, bgCornerRadius!)
           
                default:
                    break
                }
            }
        }
    }
}
