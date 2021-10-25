//
//  MALUISearchBarExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

class MALUISearchBarExtension: UISearchBar {


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
