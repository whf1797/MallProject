//
//  MALBaseViewController.swift
//  MallProject

//   Created by 张昭 on 2021/9/29.
//

import UIKit


class MALBaseViewController: UIViewController {

    public var szpBaseTableView: UITableView?
    public var szpBaseCollectionView: UICollectionView?

    var backBlock: (() -> Void)?

    private var backToHomeVC = false
    
    
    

    /// 设置UI（使用snapkit，不能写入到viewdidlayout方法中，否则无法自适应布局）
    public func configUI() {}
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        p_hideNavigationBar(true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let aes = MALAes.Encode_AES_ECB(strToEncode: "abc")
        
        // 测试接口
//        MALUserViewModel.init().getAddressList(curPage: 0, pageSize: 1)
//        MALUserViewModel.init().getUserInfo {
//        }
        
//        MALUserViewModel.init().getInviteList(curPage: 1, pageSize: 1) {
//
//        }
        // 获取顶点列表
//        MALOrderViewModel.init().getOrderList(curPage: 1, pageSize: 10, key: "1", status: .Payed) {
//
//        }
        
//        let param = MALMakeOrderParamModel.init(id: 0, num: 0)
//        // 确定顶点
//        MALOrderViewModel.init().createOrder(addressId: 0, payType: .GWB, list: [param]) {
//
//        }
        
//        MALCartViewModel.init().getCartList(curPage: 1, pageSize: 10) {
//
//        }
//        MALProViewModel.init().reqProList(type: .GWBList, curPage: 1, pageSize: 10) {
//
//        }
        
        
//        MALProViewModel.init().reqDrawal(param: MALDrawalParam.init(bankName: "", cardNo: "", cashAmt: 1, realName: "", secPwd: "", smsCode: "")) {
//
//        }
        
        MALSmsViewModel.init().reqPicSms {

        }
        
//        MALSmsViewModel.init().reqCodeSms(type: .CashOut, mobile: "", userCode: "") {
//            
//        }
        
        view.backgroundColor = UIColor.AppColor.searchBgColor

        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
        }
        
      
        
    
        
    }

    func showBackItem(_ backActionToHome: Bool = false, _ title:String = "", _ isLogin:Bool = false) {

        backToHomeVC = backActionToHome
        titleLabel.text = title
        
        if(isLogin == true){
            
            backButton.isHidden = true
            
        }else{
            backButton.isHidden = false
        }
        

        navigationView.addSubview(backButton)
        navigationView.addSubview(titleLabel)

       // backButton.backgroundColor = UIColor.red
        backButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: MAL_Value(40), height: MAL_Value(40)))
            make.left.equalTo(MAL_Value(8))
            make.centerY.equalTo(20 + kStatusBarHeight)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(kStatusBarHeight)
            make.height.equalTo(44)
            make.width.equalTo(MAL_Value(200))
            make.centerX.equalToSuperview()
        }
    }
    // MARK: private
    @objc public func p_clickBackItem() {

        guard let block = backBlock else {
            if backToHomeVC {
                AppManager.pushTabbarVC()
                
            } else {
                
                self.navigationController?.popViewController(animated: true)
            }
            return }
       block()
    }

     func p_hideNavigationBar(_ hidden: Bool) {

        self.navigationController?.setNavigationBarHidden(hidden, animated: true)
    }

    /// 设置导航栏透明
    func clearNavtionView() {
        view.bringSubviewToFront(navigationView)
        navigationView.backgroundColor = UIColor.clear
    }

    /// 自定义返回按钮图片
    var backIcon: UIImage? {
        didSet {
            backButton.setImage(backIcon, for: .normal)
        }
    }
    // MARK: get,set
    override var title: String? {
        didSet {
            titleLabel.text = title
            topNavigationView.loadTitle(title ?? "")
        }
    }
    var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
  public  lazy var backButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.contentMode = UIButton.ContentMode.center
        button.setImage(MAL_ImageNamed("nav_icon_back"), for: .normal)
        button.addTarget(self, action: #selector(p_clickBackItem), for: .touchUpInside)
        return button
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.szpHelveticaFont(18)
        return label
    }()


    func showNavigationTitle(_ title:String) {
        view.removeSubviews()
        view.addSubview(topNavigationView)
        topNavigationView.backItemBlock = { [weak self] in
            self?.p_clickBackItem()
        }
        
     
        
      
        
        topNavigationView.backgroundColor = UIColor.white
        topNavigationView.loadTitle(title)
        topNavigationView.snp.remakeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
        }
    }

    lazy var topNavigationView: SZPNaView = {
        let view = SZPNaView(frame: .zero, viewType: .typeOfTitle)
        return view
    }()
}


extension MALBaseViewController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
   
     

    /// 侧滑返回功能，拦截手势触发
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        

            

        return self.navigationController?.children.count ?? 0 > 1
            
            
      
 

       
    }
    
  

}

enum KNaVViewOfType:String {
    case typeOfBack,
         typeOfTitle,
         typeOfCart,
         typeOfShare,
         typeOfSearch
}

class SZPNaView: UIView {
    
    var backItemBlock: (() -> Void)?
    var clickCartItemBlock: (() -> Void )?
    var shareBlock: (() -> Void )?
    private var type:KNaVViewOfType = .typeOfBack
    init(frame: CGRect, viewType:KNaVViewOfType) {
        super.init(frame: frame)

        type = viewType
        addSubview(coententView)
        
       // leftBackButton.backgroundColor = UIColor.red
       // shareButton.backgroundColor = UIColor.red
        
        //cartButton.backgroundColor = UIColor.red

        switch viewType {
        case .typeOfBack:
            coententView.addSubview(leftBackButton)
        case .typeOfTitle:
            coententView.addSubview(leftBackButton)
            coententView.addSubview(titleLabel)
        case .typeOfCart:
            coententView.addSubview(leftBackButton)
            coententView.addSubview(titleLabel)
            coententView.addSubview(cartButton)
        case .typeOfShare:
            coententView.addSubview(leftBackButton)
            coententView.addSubview(titleLabel)
            coententView.addSubview(cartButton)
            coententView.addSubview(shareButton)
        default:
            break
        }
    }

    /// title名称
    public func loadTitle(_ title:String?, _ textColor: UIColor = UIColor.AppColor.titleColorLightBlack) {
        titleLabel.textColor = textColor
        titleLabel.text = title
    }


    /// 修改文字与返回按钮白色
    public func changeStateWhite() {

        leftBackButton.setImage(MAL_ImageNamed("nav_icon_back_white"), for: .normal)
        titleLabel.textColor = UIColor.white
    }
    public func refreshBackIcon(icon:String = "nav_icon_back", title:String = "", cartIcon:String = "nav_ic_cart_n", shareIcon:String = "nav_ic_share_n") {

        if !icon.isEmpty {
            leftBackButton.setImage(MAL_ImageNamed(icon), for: .normal)
        }
        if !title.isEmpty {

            titleLabel.text = title
        }
        if !cartIcon.isEmpty {

            cartButton.setImage(MAL_ImageNamed(cartIcon), for: .normal)
        }
        if !shareIcon.isEmpty {

            shareButton.setImage(MAL_ImageNamed(shareIcon), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        coententView.snp.remakeConstraints { (make) in
            make.left.width.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
        leftBackButton.snp.remakeConstraints { (make) in
            make.left.equalTo(MAL_Value(8))
            make.width.height.equalTo(MAL_Value(40))
            make.centerY.equalToSuperview().offset(MAL_Value(3))
        }
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(leftBackButton)
            make.height.equalTo(MAL_Value(25))
            make.width.equalTo(MAL_Value(300))
            make.centerX.equalToSuperview()
        }

        switch type {
        case .typeOfCart:

                cartButton.snp.remakeConstraints { (make) in
                    make.top.size.equalTo(leftBackButton)
                    make.right.equalTo(MAL_Value(-15))
                }
        case .typeOfShare:
                shareButton.snp.remakeConstraints { (make) in
                    make.top.size.equalTo(leftBackButton)
                    make.right.equalTo(MAL_Value(-10))
                }
                cartButton.snp.remakeConstraints { (make) in
                    make.top.size.equalTo(leftBackButton)
                    make.right.equalTo(shareButton.snp.left).offset(MAL_Value(-5))
                }
        default:
                break
        }
    }

    private lazy var coententView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var leftBackButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setImage(MAL_ImageNamed("nav_icon_back"), for: .normal)
        view.addTarget(self, action: #selector(p_clickBackItem), for: .touchUpInside)
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let view = UILabel.init(text: "")
        view.font = UIFont.szpHelveticaFont(18)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        view.textAlignment = .center
        return view
    }()
     lazy var cartButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setImage(MAL_ImageNamed("ic_nav_catalogue_shop"), for: .normal)
        view.addTarget(self, action: #selector(p_clickCartItem), for: .touchUpInside)
        return view
    }()
    private lazy var shareButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setImage(MAL_ImageNamed("nav_ic_share_n"), for: .normal)
        view.addTarget(self, action: #selector(p_clickShareItem), for: .touchUpInside)
        return view
    }()
    @objc private func p_clickShareItem() {
//        debugPrint("点击了按钮：分享")
     //   SZPShareAlertView.showShareAlert()
        
        
        
        guard let block = shareBlock else { return }
        block()
        
   

        
    }
    @objc private func p_clickCartItem() {
        debugPrint("点击了按钮：购物车")
        guard let block = clickCartItemBlock else { return }
        block()
    }
    @objc private func p_clickBackItem() {
        debugPrint("点击了按钮：返回")
        guard let block = backItemBlock else {
            let currentVC = UIViewController.getTopViewController()
            currentVC?.navigationController?.popViewController(animated: true)
            return }
      
       block()
    }
}
extension SZPNaView: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        debugPrint("跳转搜索页面")
    
        return false
    }
}

extension MALBaseViewController {

    /// 停止刷新
    /// - Parameter nomoreData: 是否显示没有更多数据
    func endRefersh(_ tableView: UITableView?, _ nomoreData: Bool? = false) {
        guard let view:UITableView = tableView else { return }

        if nomoreData! {
            view.mj_header?.endRefreshing()
            view.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            view.mj_header?.endRefreshing()
            view.mj_footer?.endRefreshing()
        }
    }
    
}

extension UITableView {

    /// 停止刷新：
    /// - Parameter nomoreData: 默认false，不显示没有更多数据
    func endRefresh(_ nomoreData: Bool = false) {
        self.mj_header?.endRefreshing()
        self.mj_footer?.endRefreshing()

        if nomoreData {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
}
