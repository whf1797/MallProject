//
//  MALProductViewController.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/5/17.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit

/// 商品详情VC
class MALProductViewController: MALBaseViewController {
    
    deinit {
        
        debugPrint("MALProductViewController销毁")
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        
        requestCartList()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    
    private lazy var carViewModel: MALShoppingCarViewMolde = {
        let viewmdoel = MALShoppingCarViewMolde()
        return viewmdoel
    }()
    
    private func requestCartList() {
        
        
       
    }
    
    



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.removeSubviews()
        view.backgroundColor = UIColor.init(hexString: "#f2f2f2")
        view.addSubview(topView)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(imageScrollView)
        contentScrollView.addSubview(productNameView)
        contentScrollView.addSubview(evaluView)
        contentScrollView.addSubview(webView)
        view.addSubview(bottomView)
        view.bringSubviewToFront(topView)
        topView.clickCartItemBlock = { [unowned self] in
          
        }
        
        topView.shareBlock = { [unowned self] in
            
       
            
        }
        
        ///加载销量
        evaluView.loadMallInfo(nil)
        
        
    
  
    }
 
    /// 课程的 商品item
    public var courseItem: SZPCartGoodsItem? {
        didSet {
            requestProductInfo(courseItem?.cartUUID)
        }
    }
    /// 商城的 商品item
    public var mallItem: MALMallModel? {
        didSet {
            requestProductInfo(mallItem?.uuid)
        }
    }

    public var tempDetail: SZPMallDetailModel?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let bottomH = MAL_Value(55) + kBottomSafeAreaHeight
        let imageScrollH =  MAL_Value(375)

        contentScrollView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - bottomH)
        topView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarHeight)
        imageScrollView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: imageScrollH)
        productNameView.frame = CGRect.init(x: 0, y: imageScrollView.bottom, width: kScreenWidth, height:  MAL_Value(120 - 18))
        evaluView.frame = CGRect.init(x: 0, y: productNameView.bottom + MAL_Value(1), width: kScreenWidth, height: MAL_Value(44))
        bottomView.frame = CGRect.init(x: 0, y: kScreenHeight - bottomH, width: kScreenWidth, height: bottomH)

        webView.snp.remakeConstraints { (make) in
            make.top.equalTo(evaluView.snp.bottom).offset(MAL_Value(10))
            make.left.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(MAL_Value(-10))
        }
    }
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.AppColor.searchBgColor
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    private lazy var topView: SZPNaView = {
        let view = SZPNaView(frame: .zero, viewType: .typeOfShare)
        view.backgroundColor = UIColor.white
        view.loadTitle("商品详情")
        view.refreshBackIcon(icon: "nav_icon_back", title: "", cartIcon: "nav_ic_cart_n", shareIcon: "nav_ic_share_n")
        return view
    }()
    private lazy var imageScrollView: MALBannerScrollView = {
        let view = MALBannerScrollView.init(frame: .zero, type: .typeOfProduct)
        view.backgroundColor = UIColor.init(hexString: "#EDEEF0")
        return view
    }()
    private lazy var productNameView: SZPProductNameView = {
        let view = SZPProductNameView.init(frame: .zero)
        return view
    }()
    private lazy var evaluView: SZPProductEvaluateView = {
        let view = SZPProductEvaluateView.init(frame: .zero)
        return view
    }()
    private lazy var webView: SZPProductWebView = {
        let view = SZPProductWebView.init(frame: .zero)
        return view
    }()
    lazy var bottomView: MALVideoPackageDetailBottomView = {
        let view = MALVideoPackageDetailBottomView.init(frame: .zero)
        return view
    }()
  
}

extension MALProductViewController {

    func requestProductInfo(_ uuid: String?) {

    }
}

extension MALProductViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offx = scrollView.contentOffset.y
        if offx > MAL_Value(10) {
            UIView.animate(withDuration: 1) { [self] in
                topView.backgroundColor = UIColor.white
            }
        } else {
            UIView.animate(withDuration: 1) { [self] in
                topView.backgroundColor = UIColor.white
            }
        }
    }
}

class SZPProductNameView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(priceLabel)

    }

    func loadMallInfo(_ mdoel: SZPMallDetailModel?) {
        guard let item = mdoel else { return }
        nameLabel.text = item.name
        priceLabel.text = MAL_Price("\(item.marketPrice)")
   
        layoutSubviews()
      
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let nameW = width - MAL_Value(30)
        
        let nameHeight = nameLabel.text?.heightWithConstrainedWidth(nameW, font: nameLabel.font)
        nameLabel.frame = CGRect(x: MAL_Value(15), y: MAL_Value(22), width: nameW, height: nameHeight ?? CGFloat(40))

        let priceH = MAL_Value(MAL_Value(33))
        let priceW = priceLabel.text!.widthWithConstrainedHeight(priceH, font: priceLabel.font)
        priceLabel.frame = CGRect(x: nameLabel.left, y: 0, width: priceW, height: priceH)
        priceLabel.bottom = height - MAL_Value(10)

 
        
        

    }
    private lazy var nameLabel: UILabel = {
        let view = UILabel.init(text: "请输入商品的名称请输入商品的名称")
        view.font = UIFont.szpHelveticaFont(18)
        view.textColor = UIColor.AppColor.titleColorLight
        view.numberOfLines = 0
        return view
    }()
    private lazy var priceLabel: UILabel = {
        let view = UILabel.init(text: MAL_Price("2800"))
        view.font = UIFont.szpHelveticaFont(24)
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        return view
    }()

  
}

class SZPProductEvaluateView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(inventoryLable)
        addSubview(courieryLable)
        addSubview(salesLable)
        
        
        
 
    }

    private var tempGoodID: String?
    private var currentDetail: SZPMallDetailModel?
    /// 加载商品详情
    func loadMallInfo(_ mdoel: SZPMallDetailModel?) {
      
        inventoryLable.text = String(format: "库存：%d件", 500)
        courieryLable.text = String(format: "快递：%@", "免运费")
        salesLable.text = String(format: "销量：%d件", 100)
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        inventoryLable.snp.remakeConstraints { make in
            
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.centerY.equalToSuperview()
            
        }
        
        courieryLable.snp.remakeConstraints { make in
            
           
            make.center.equalToSuperview()
            
        }
        
        salesLable.snp.remakeConstraints { make in
            
            make.right.equalToSuperview().offset(-MAL_Value(15))
            make.centerY.equalToSuperview()
            
        }
        
        
        
     
    }
    //库存
    lazy var inventoryLable: UILabel = {
        
        let view = UILabel.init()
        view.font = UIFont.szpAppleNormalFont(14)
        view.textColor = UIColor.AppColor.lightGrayColor
        
        return view
     
    }()
    
    //快递
    lazy var courieryLable: UILabel = {
        
        let view = UILabel.init()
        view.font = UIFont.szpAppleNormalFont(14)
        view.textColor = UIColor.AppColor.lightGrayColor
        return view
     
    }()
    
    //销量
    lazy var salesLable: UILabel = {
        
        let view = UILabel.init()
        view.font = UIFont.szpAppleNormalFont(14)
        view.textColor = UIColor.AppColor.lightGrayColor
        return view
     
    }()
    
   
    
    

}

class SZPProductWebView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(productTipButton)
        addSubview(productWebView)
//        productWebView.loadWebUrl("https://www.baidu.com", false)
        productTipButton.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.left.equalToSuperview().offset(MAL_Value(15))
            make.height.equalTo(MAL_Value(40))
        }
        productWebView.snp.makeConstraints { (make) in
            make.top.equalTo(productTipButton.snp.bottom)
            make.left.width.equalToSuperview()
            make.height.equalTo(kScreenHeight)
            make.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 加载商品详情
    func loadMallInfo(_ mdoel: SZPMallDetailModel?) {
        guard let item = mdoel else { return }
        let htmlString = item.details.first
        productWebView.loadHTMLString(htmlString)
        productWebView.snp.remakeConstraints { (make) in
            make.top.equalTo(productTipButton.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(productWebView.height)
            make.bottom.equalToSuperview()
        }
    }

    private lazy var productTipButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor = UIColor.white
        view.setTitle("商品详情".local, for: .normal)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(18)
       // let image = UIImage.init(color: UIColor.AppColor.main, size: CGSize.init(width: MAL_Value(4), height: MAL_Value(16)))
       // view.setImage(image, for: .normal)
        view.contentHorizontalAlignment = .left
       // view.setContentAndTitleSpace(MAL_Value(10), MAL_Value(8))
        return view
    }()

    private lazy var productWebView: SZPWebView = {
        let view = SZPWebView.init(frame: .zero)
        return view
    }()
}
