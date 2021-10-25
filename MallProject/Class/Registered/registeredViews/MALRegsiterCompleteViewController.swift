//
//  MALRegsiterCompleteViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/24.
//

import UIKit

class MALRegsiterCompleteViewController: MALBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(tempTopView)
        tempTopView.loadTitle("注册会员",UIColor.white)
        view.backgroundColor = .white

        

    }
    
    
    lazy var tempTopView: SZPNaView = {
        let view = SZPNaView.init(frame: .zero, viewType: .typeOfTitle)
        view.backgroundColor = UIColor.AppColor.main
        view.refreshBackIcon(icon: "nav_icon_with", title: "", cartIcon: "", shareIcon: "")
        view.alpha = 1
        return view
    }()
    
  
    


}
