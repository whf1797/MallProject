//
//  MALHomeCourseView.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/06.
//

import UIKit

enum HomeCourseType: Int {
    case typeOfNew
    case typeOfFree
    case typeOfLive
    case typeOfVideo
}

/// 首页，分类四个按钮 View
class MALHomeCourseView: UIView {

    typealias KClickButtonAction = (_ type:HomeCourseType) -> Void
    var clickItemBlock:KClickButtonAction!


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white

        addSubview(newButton)
        addSubview(freeButton)
        addSubview(liveButton)
        addSubview(videoButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        let itemH = MAL_Value(70)
        let itemW = MAL_Value(UI_IS_IPHONE6 ? 50 : 51)
        let space  = MAL_Value(44)
        let offx  = (width - itemW * 4 - space * 3) * 0.5
        
        
    
        newButton.frame  = CGRect.init(x: offx, y: (height - itemH) * 0.5, width: itemW, height: itemH)
        freeButton.frame  = CGRect.init(x: newButton.right + space, y: newButton.top, width: itemW, height: itemH)
        liveButton.frame  = CGRect.init(x: freeButton.right + space, y: newButton.top, width: itemW, height: itemH)
        videoButton.frame  = CGRect.init(x: liveButton.right + space, y: newButton.top, width: itemW, height: itemH)
    }

    @objc func p_clickButton(_ sender:UIButton) {

        debugPrint("当前点击的按钮状态是：\(sender)")
       // clickItemBlock(HomeCourseType(rawValue: sender.tag)!)
    }

    lazy var newButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor  = UIColor.clear
        view.contentHorizontalAlignment  = .center
        view.setImage(MAL_ImageNamed("category_1"), for: .normal)
        view.setTitle("分类".local, for: .normal)
        view.titleLabel?.font  = UIFont.systemFont(ofSize: 12)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.tag  = HomeCourseType.typeOfNew.rawValue
        view.centerTextAndImage(imageAboveText: true, spacing: MAL_Value(4))
        view.addTarget(self, action: #selector(p_clickButton(_:)), for: .touchUpInside)
        return view
    }()
    lazy var freeButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor  = UIColor.clear
        view.contentHorizontalAlignment  = .center

        view.setImage(MAL_ImageNamed("category_2"), for: .normal)
        view.setTitle("分类".local, for: .normal)
        view.titleLabel?.font  = UIFont.systemFont(ofSize: 12)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.centerTextAndImage(imageAboveText: true, spacing: MAL_Value(4))
        view.tag  = HomeCourseType.typeOfFree.rawValue
        view.addTarget(self, action: #selector(p_clickButton(_:)), for: .touchUpInside)
        return view
    }()
    lazy var liveButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor  = UIColor.clear
        view.contentHorizontalAlignment  = .center

        view.setImage(MAL_ImageNamed("category_3"), for: .normal)
        view.setTitle("分类".local, for: .normal)
        view.titleLabel?.font  = UIFont.systemFont(ofSize: 12)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.centerTextAndImage(imageAboveText: true, spacing: MAL_Value(4))
        view.tag  = HomeCourseType.typeOfLive.rawValue
        view.addTarget(self, action: #selector(p_clickButton(_:)), for: .touchUpInside)
        return view
    }()
    lazy var videoButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor  = UIColor.clear
        view.contentHorizontalAlignment  = .center

        view.setImage(MAL_ImageNamed("category_4"), for: .normal)
        view.setTitle("更多".local, for: .normal)
        view.titleLabel?.font  = UIFont.systemFont(ofSize: 12)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.centerTextAndImage(imageAboveText: true, spacing: MAL_Value(4))
        view.tag  = HomeCourseType.typeOfVideo.rawValue
        view.addTarget(self, action: #selector(p_clickButton(_:)), for: .touchUpInside)
        return view
    }()
}



