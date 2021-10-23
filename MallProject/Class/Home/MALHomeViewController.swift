//
//  MALHomeViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit
import Kingfisher
import SafariServices
//首页VC
class MALHomeViewController: MALBaseViewController {
    
    deinit {
        
        debugPrint("MALHomeViewController销毁")
       
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var bannerItem =  SZPBannerItem.init()
        bannerItem.bannerUrl = "http://img.jj20.com/up/allimg/tp03/1Z92313003GR4-0-lp.jpg"
        
        var bannerItem2 =  SZPBannerItem.init()
        bannerItem2.bannerUrl = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2Ftp05%2F1Z92Z010314610-0-lp.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1636092394&t=0e3263995aabc65e28e96ee64d00bbcf"
        bannerScrollView.loadBannerList([bannerItem,bannerItem2])
        
       
        
        
        
   
        view.addSubview(topView)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(bannerScrollView)
        contentScrollView.addSubview(courseItemsView)
        contentScrollView.addSubview(productsHeaderView)
        contentScrollView.addSubview(productsViewList)
        contentScrollView.addSubview(leftBtn)
        contentScrollView.addSubview(rightBtn)
        contentScrollView.addSubview(announcementView)
        
        announcementView.loade()
        
     
        
        topView.snp.remakeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight + MAL_Value(5))
          
        }
        contentScrollView.snp.remakeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.width.bottom.equalToSuperview()
        }
        bannerScrollView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(MAL_Value(170))
        }
        
        courseItemsView.snp.remakeConstraints { (make) in
            
            make.top.equalTo(bannerScrollView.snp.bottom).offset(MAL_Value(5))
            make.width.equalToSuperview()
            make.height.equalTo(MAL_Value(90))
           
        }
        
        productsHeaderView.snp.remakeConstraints { (make) in
            make.top.equalTo(courseItemsView.snp.bottom).offset(MAL_Value(5))
            make.width.centerX.equalToSuperview()
            make.height.equalTo(MAL_Value(43))
        }
     
        productsViewList.snp.remakeConstraints { (make) in
            make.top.equalTo(productsHeaderView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(MAL_Value(173))
        }
        
        leftBtn.snp.remakeConstraints { make in
            
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.width.equalTo(MAL_Value(167))
            make.height.equalTo(MAL_Value(62))
            make.top.equalTo(productsViewList.snp.bottom).offset(MAL_Value(16))
            
        }
        
        rightBtn.snp.remakeConstraints { make in
            
            make.top.equalTo(productsViewList.snp.bottom).offset(MAL_Value(16))
            make.right.equalTo(view.snp.right).offset(MAL_Value(-15))
            make.width.equalTo(MAL_Value(167))
            make.height.equalTo(MAL_Value(62))
           
            
        }
        
        announcementView.snp.remakeConstraints { make in
           
      
            make.top.equalTo(rightBtn.snp.bottom).offset(MAL_Value(16))
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.right.equalToSuperview().offset(-MAL_Value(15))
            make.bottom.equalToSuperview().offset(-MAL_Value(10))
           
            
        }
        
      
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    
    }
    
    lazy var topView: MALNavView = {
        let view = MALNavView.init(frame: .zero)
        return view
    }()
    private lazy var contentScrollView: UIScrollView = {
         let view = UIScrollView()
         view.showsVerticalScrollIndicator = false
         view.showsHorizontalScrollIndicator = false
         view.backgroundColor = UIColor.AppColor.searchBgColor
         view.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(p_loadData))
        view.mj_footer = MJRefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(p_loadData))
         return view
     }()
    
    private lazy var bannerScrollView: MALBannerScrollView = {
        let view = MALBannerScrollView(frame: .zero, type: .typeOfHome)
        return view
    }()
    
    private lazy var courseItemsView: MALHomeCourseView = {
        let view  = MALHomeCourseView.init(frame: .zero)
        return view
    }()
    
    private lazy var productsHeaderView: MALHomeHotCourseHeader = {
        let view  = MALHomeHotCourseHeader.init(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var productsViewList: MALRecommendedProductsView = {
        let view  = MALRecommendedProductsView.init(frame: .zero)
        return view
    }()
    
    private lazy var announcementView: MALAnnouncementView = {
        let view  = MALAnnouncementView.init(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = MAL_Value(10)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hexString: "#c8c8c8")?.cgColor
       
        return view
    }()
    
    
    
    
    
    @objc private func p_loadData() {
        
        contentScrollView.mj_header.endRefreshing()
      
    }
    /// 推荐列表
    private lazy var leftBtn: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.setBackgroundImage(MAL_ImageNamed("btnBackImage"), for: .normal)
        view.setTitle("推荐列表", for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(20)
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        view.addTarget(self, action: #selector(goToRecommList), for: .touchUpInside)
        return view
    
    }()
    ///进入推荐列表
    @objc func goToRecommList(){
        
        let pushVC = MALRecomListViewController()
        self.navigationController?.pushViewController(pushVC, animated: true)
    
    
    }
    
    ///用户列表
    private lazy var rightBtn: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.setBackgroundImage(MAL_ImageNamed("btnBackImage"), for: .normal)
        view.setTitle("用户列表", for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(20)
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        return view
    
    }()
    
    
    
    
    
    

}

class MALAnnouncementView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        
       
      
    }
    func loade(){
        
        let paraph = NSMutableParagraphStyle()
              //将行间距设置为28
              paraph.lineSpacing = 10
              //样式属性集合
        let attributes = [NSAttributedString.Key.font:contentLabel.font,
                          NSAttributedString.Key.paragraphStyle: paraph]
        contentLabel.attributedText = NSAttributedString(string: "公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息", attributes: attributes as [NSAttributedString.Key : Any])
         
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(MAL_Value(20))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(MAL_Value(15))
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(MAL_Value(20))
            make.right.equalToSuperview().offset(MAL_Value(-20))
            
            make.bottom.equalToSuperview().offset(-MAL_Value(10))
        }
    }
    
    lazy var titleLabel: UILabel = {
       
        let view = UILabel.init()
        view.text = "公告信息"
        view.textAlignment = .center
        view.textColor = UIColor.AppColor.titleColorLightBlack
        view.font = UIFont.szpAppleNormalFont(18)
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        
        let view = UILabel.init()
        view.text = "公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息公告信息"
        view.textColor = UIColor.AppColor.titleColorLight
        view.font = UIFont.szpAppleNormalFont(12)
        view.numberOfLines = 0
        return view
        
        
    }()
    
    
    
}




///推荐产品hearderView
class MALHomeHotCourseHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameButton)
        addSubview(moreButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        nameButton.frame = CGRect.init(x: MAL_Value(15), y: 0, width: MAL_Value(90), height: MAL_Value(25))
        nameButton.setTitleSpace(MAL_Value(5))
        nameButton.centerY = height * 0.5
        
        moreButton.snp.remakeConstraints { make in
            
            make.right.equalToSuperview()
            make.size.equalTo(CGSize.init(width: MAL_Value(40), height: MAL_Value(25)))
            make.centerY.equalToSuperview()
            
        }
      
        
        
    }

    private lazy var nameButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("推荐产品".local, for: .normal)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(15)
        view.setImage(MAL_ImageNamed("home_title_label_course"), for: .normal)
        view.contentHorizontalAlignment = .left
        return view
    }()
    
    private lazy var moreButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("更多".local, for: .normal)
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(12)
        view.setImage(MAL_ImageNamed("home_title_label_course"), for: .normal)
        view.addTarget(self, action: #selector(goSearchGoods), for: .touchUpInside)
        view.contentHorizontalAlignment = .left
        return view
    }()
    
    @objc func goSearchGoods(){
        
        let currentVC = UINavigationController.getTopViewController()
        let searchVC = MALSearchViewController()
        currentVC?.navigationController?.pushViewController(searchVC)
   
    }
    
}
///导航栏样式
class MALNavView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.AppColor.main
        addSubview(heardIconImageView)
        addSubview(idLabel)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

    override func layoutSubviews() {
        super.layoutSubviews()
        
        heardIconImageView.snp.remakeConstraints { make in
            
            make.left.equalTo(MAL_Value(20))
            make.size.equalTo(40)
            make.bottom.equalToSuperview().offset(MAL_Value(-5))
         
        }
        idLabel.snp.remakeConstraints { make in
            
            make.centerY.equalTo(heardIconImageView)
            make.left.equalTo(heardIconImageView.snp.right).offset(MAL_Value(10))
    
         
        }
    }

    lazy var heardIconImageView: UIImageView = {
        
        let view = UIImageView.init()
        view.layer.masksToBounds = true
        view.layer.cornerRadius =  40 / 2.0
        view.backgroundColor = UIColor.white
        view.image = MAL_ImageNamed("heardIcon")
        return view
        
    }()
    
    lazy var idLabel :UILabel = {
        
        let view = UILabel.init()
        view.textColor = UIColor.white
        view.text = "ID:12345678"
        view.font = UIFont.szpAppleNormalFont(15)
        return view
        
    }()

  
}


