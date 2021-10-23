//
//  MALRecomListViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/16.
//

import UIKit
//推荐列表VC
class MALRecomListViewController: MALBaseViewController {
    
    private var tempPage: Int = 1
    private var isNomoreData: Bool = false
    
    var dataList:[Any]? {
        didSet {
            contentView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.AppColor.backgroundColorNormal
        tempTopView.loadTitle("推荐列表")
        view.addSubview(tempTopView)
        view.addSubview(contentView)

        tempTopView.snp.remakeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
          
        }
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavigationBarHeight)
            make.left.width.equalToSuperview()
           make.bottom.equalToSuperview()
        }
        
        contentView.reloadData()
        createRefresh()
        
    }
    
    lazy var tempTopView: SZPNaView = {
        let view = SZPNaView.init(frame: .zero, viewType: .typeOfTitle)
        view.backgroundColor = UIColor.white
        view.refreshBackIcon(icon: "nav_icon_back", title: "", cartIcon: "ic_nav_catalogue_shop", shareIcon: "nav_ic_share_y")
        view.alpha = 1
        return view
    }()

    lazy var contentView: UITableView = {
        let view = UITableView()
        view.backgroundColor = UIColor.AppColor.searchBgColor
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator  = false
        view.estimatedRowHeight = MAL_Value(120)
        view.rowHeight = UITableView.automaticDimension
        view.tableFooterView = UIView()
        view.ly_emptyView = LYEmptyView.empty(withImageStr: "icon_no_data", titleStr: "暂时还没有数据".local, detailStr: "")
        return view
    }()

}

extension MALRecomListViewController {

    // MARK: - 下拉刷新操作
    func createRefresh() {
        contentView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(p_loadData))
        contentView.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(p_loadMoreData))
    }
    @objc private func p_loadData() {
        tempPage = 1
        isNomoreData = false
        reqeustListByPage(1)
    }
    @objc private func p_loadMoreData() {
        if isNomoreData {
            contentView.endRefresh()
            return
        }
        tempPage += 1
        reqeustListByPage(tempPage)
    }

    func reqeustListByPage(_ page: Int) {

        contentView.endRefresh(true)
    }

    func p_handleList( _ page: Int, _ items: [Any]?) {

        if items?.isEmpty == true{
            isNomoreData = true
            contentView.endRefresh(true)
            
            if(page == 1){
                dataList?.removeAll()
                dataList = items
            }
            
            return
        }
        contentView.endRefresh()
        if page == 1 {
            isNomoreData = false
            dataList?.removeAll()
            dataList = items
        } else {
            dataList! += items!
        }
    }
    
}

extension MALRecomListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }

 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = MALRecomCell.cellWithTableView(tableView)
        cell.loadInfo(MALRecommendedModel.init())
 
        return cell
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

   
    }
    
    
    
}

/// 直播预约的cell
class MALRecomCell: UITableViewCell {


    class func cellWithTableView(_ tableView:UITableView) -> MALRecomCell {

        tableView.register(cellWithClass: MALRecomCell.self)
        let identifier = "MALRecomCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = MALRecomCell.init(style: .default, reuseIdentifier: identifier)
        }
        tableView.separatorStyle = .none

        return cell! as! MALRecomCell
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.AppColor.backgroundColorNormal
        selectionStyle = .none
        contentView.addSubview(itemView)
        itemView.addSubview(memberNumber)
        itemView.addSubview(nameLabel)
        itemView.addSubview(hierarchyLabel)
        itemView.addSubview(resultsLabel)
        itemView.addSubview(timeLabel)
        
        itemView.addSubview(statue1)
        itemView.addSubview(sliderView)
        itemView.addSubview(statue2)
        itemView.addSubview(sliderView2)
        itemView.addSubview(statue3)
    }

    func loadInfo(_ model: MALRecommendedModel?) {

        layoutSubviews()
       
        
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let offx = MAL_Value(15)
        let sapce = MAL_Value(10)
        itemView.snp.remakeConstraints { (make) in
            make.top.equalTo(MAL_Value(5))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        
        }
        
        let memWith = memberNumber.requiredWidth(MAL_Value(14))
        memberNumber.snp.remakeConstraints { make in
            
            make.left.equalToSuperview().offset(offx)
            make.top.equalTo(sapce)
            make.width.equalTo(memWith)
            make.height.equalTo(MAL_Value(15))
            
        }
        
        let nameWith = nameLabel.requiredWidth(MAL_Value(14))
        
        nameLabel.snp.remakeConstraints { make in
            
            make.left.equalTo(memberNumber.snp.left)
            make.top.equalTo(memberNumber.snp.bottom).offset(sapce)
            make.width.equalTo(nameWith > width / 2 ? width / 2 : nameWith)
            make.height.equalTo(MAL_Value(14))
       
        }
        let hierarchyWith = hierarchyLabel.requiredWidth(MAL_Value(14))
        hierarchyLabel.snp.remakeConstraints { make in
            
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().offset(-offx)
            make.width.equalTo(hierarchyWith)
            make.height.equalTo(MAL_Value(14))
            
        }
        
        let resultsWith = resultsLabel.requiredWidth(MAL_Value(14))
        resultsLabel.snp.remakeConstraints { make in
            
            make.left.equalTo(memberNumber)
            make.top.equalTo(nameLabel.snp.bottom).offset(sapce)
            make.width.equalTo(resultsWith)
            make.height.equalTo(MAL_Value(14))
        }
        
        let timeWith = timeLabel.requiredWidth(MAL_Value(14))
        timeLabel.snp.remakeConstraints { make in
            
            make.right.equalToSuperview().offset(-offx)
            make.centerY.equalTo(resultsLabel)
            make.width.equalTo(timeWith)
            make.height.equalTo(MAL_Value(14))
         
            
            
        }
        
        statue3.snp.remakeConstraints { make in
            
            make.top.equalTo(timeLabel.snp.bottom).offset(sapce)
            make.right.equalTo(timeLabel.snp.right)
         
         
            make.bottom.equalTo(itemView.snp.bottom).offset(-MAL_Value(10))
            
        }
        
        sliderView2.snp.remakeConstraints { make in
            
            make.right.equalTo(statue3.snp.left).offset(-1)
            make.centerY.equalTo(statue3)
            make.height.equalTo(statue3)
            make.width.equalTo(1)
            
        }
        
        statue2.snp.remakeConstraints { make in
            
            make.top.equalTo(timeLabel.snp.bottom).offset(sapce)
            make.right.equalTo(sliderView2.snp.left).offset(-1)
          
         
            
        }
        
        sliderView.snp.remakeConstraints { make in
            
            make.right.equalTo(statue2.snp.left).offset(-1)
            make.centerY.equalTo(statue2)
            make.height.equalTo(statue2)
            make.width.equalTo(1)
          
            
        }
        
        statue1.snp.remakeConstraints { make in
            
            make.top.equalTo(timeLabel.snp.bottom).offset(sapce)
            make.right.equalTo(sliderView.snp.left).offset(-1)
          
        
        }
        
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    lazy var itemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    

    /// 会员编号
    lazy var memberNumber: UILabel = {
        let view = UILabel.init(text: "会员编号：12345678")
        view.font = UIFont.szpAppleNormalFont(15)
        view.textColor = UIColor.AppColor.titleColorLight
        return view
    }()
    lazy var nameLabel: UILabel = {
        let view = UILabel.init(text: "姓名：昵称")
        view.font = UIFont.szpAppleNormalFont(12)
        view.textColor = UIColor.AppColor.lightGrayColor
        return view
    }()
    
    
    ///层级
    lazy var hierarchyLabel: UILabel = {
        let view = UILabel.init(text: "层级：1|2")
        view.font = UIFont.szpAppleNormalFont(12)
        view.textColor = UIColor.AppColor.lightGrayColor
        view.textAlignment = .right
        return view
    }()
    
    ///业绩
    lazy var resultsLabel: UILabel = {
        let view = UILabel.init(text: "业绩：左市场|右市场")
        view.font = UIFont.szpAppleNormalFont(12)
        view.textColor = UIColor.AppColor.lightGrayColor
        return view
    }()
    ///时间
    lazy var timeLabel: UILabel = {
        let view = UILabel.init(text: "2021-09-23 10:00:00")
        view.font = UIFont.szpAppleNormalFont(12)
        view.textColor = UIColor.AppColor.lightGrayColor
        return view
    }()
    
    ///状态1
    lazy var statue1: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(13)
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        view.setTitleColor(UIColor.AppColor.main, for: .selected)
        view.setTitle("正常", for: .normal)
        return view
      
    }()
    
    lazy var sliderView: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = UIColor.AppColor.lightGrayColor
        return view
    
    }()
    ///状态2
    lazy var statue2: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(13)
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        view.setTitleColor(UIColor.AppColor.main, for: .selected)
        view.setTitle("锁定", for: .normal)
        return view
      
    }()
    
    lazy var sliderView2: UIView = {
        
        let view = UIView.init()
        view.backgroundColor = UIColor.AppColor.lightGrayColor
        return view
    
    }()
    
    ///状态3
    lazy var statue3: UIButton = {
        
        let view = UIButton.init(type: .custom)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(13)
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        view.setTitleColor(UIColor.AppColor.main, for: .selected)
        view.setTitle("注销", for: .normal)
        return view
      
    }()
    
    
 
 
}

