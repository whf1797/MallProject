//
//  SZPSearchViewController.swift
//  MaintenanceProj
//
//  Created by Zhipeng on 2021/5/4.
//  Copyright © 2021 Suo. All rights reserved.
//

import UIKit

/// 搜索页VC
class MALSearchViewController: MALBaseViewController {
    
    deinit {
        debugPrint("MALSearchViewController销毁")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
   
        
    }
    
    lazy var contentView: MALSearchResultView = {
        let view = MALSearchResultView()
        return view
    }()


}

class MALSearchResultView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(tempTopView)
        tempTopView.addSubview(searchBarView)
        addSubview(listView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tempTopView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarHeight)
        searchBarView.frame = CGRect.init(x: 0, y: kStatusBarHeight + (44 - MAL_Value(23)) / 2 , width: MAL_Value(250), height: MAL_Value(23))
        searchBarView.right = tempTopView.right - MAL_Value(30)
        searchBarView.layer.masksToBounds = true
        searchBarView.layer.cornerRadius =  MAL_Value(23) / 2.0
       
        searchBarView.setPositionAdjustment(UIOffset.init(horizontal: MAL_Value(125) / 2.0, vertical: 0), for: .search)
        
        listView.snp.remakeConstraints { make in
            
            make.top.equalToSuperview().offset(kNavigationBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().offset(-(kNavigationBarHeight + kBottomSafeAreaHeight) )
        }
        
        
        
    }
    
    
    lazy var tempTopView: SZPNaView = {
        let view = SZPNaView.init(frame: .zero, viewType: .typeOfTitle)
        view.backgroundColor = UIColor.AppColor.main
        view.refreshBackIcon(icon: "nav_icon_with", title: "", cartIcon: "ic_nav_catalogue_shop", shareIcon: "nav_ic_share_y")
        view.alpha = 1
        return view
    }()
   
    lazy var searcheBarTopView: UIView = {
        
        let view = UIView.init()
        return view
    }()
  
    
    private lazy var searchBarView: SZPUISearchBarExtension = {
        let view = SZPUISearchBarExtension.init(frame: .zero)
        view.backgroundColor =  UIColor.white
        var searchField = view.textField
        
        if(searchField == nil){
            
            searchField = view.value(forKey:"_searchField") as? UITextField
            searchField?.backgroundColor = UIColor.clear
            
            
            
            
        }
     
        searchField?.textColor = UIColor.AppColor.main
        searchField?.backgroundColor = UIColor.clear
        searchField?.clearButtonMode = .whileEditing
        searchField?.font = UIFont.szpAppleNormalFont(14)
        view.setImage(MAL_ImageNamed("ic_search"), for: .search, state: .normal)
        view.placeholder = "搜索商品".local
        view.delegate = self
        return view
    }()
    
    lazy var listView: UITableView = {
        let table = UITableView.init(frame: .zero)
        table.backgroundColor = UIColor.AppColor.searchBgColor
        table.tableFooterView = UIView()
        //        // 不设置，会导致获取contentsize不准确（设置=0，可以解决）,同时也是自适应高度的关键代码
        //        table.estimatedRowHeight = MAL_Value(120)
        //        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.ly_emptyView = LYEmptyView.empty(withImageStr: "icon_no_data", titleStr: "暂时还没有数据".local, detailStr: "")
        return table
    }()
   
    
    
}
extension MALSearchResultView: UISearchBarDelegate {

    /// 隐藏键盘
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
      
        return super.hitTest(point, with: event)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 点击搜索按钮，开始搜索
        guard let keyword = searchBar.text else {
            return
        }
       
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let topVC = UITableViewController.getTopViewController()
        topVC?.navigationController?.popViewController(animated: true)
    }
}

extension MALSearchResultView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
 
            return 1
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
       // return cartInfo?.validList.count ?? 0
        return 10

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MAL_Value(144)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = SZPMallCell.cellWithTableView(tableView)
          
            return cell
        
    }
}

/// 商城搜索
class SZPMallCell: UITableViewCell {


    var changeItemSelectedBlock: ( (_ selectedState: Bool) -> Void )?
    var changeItemCountBlock: ( (_ isAdd: Bool, _ goodsID: String?) -> Void )?


    class func cellWithTableView(_ tableView:UITableView) -> SZPMallCell {

        tableView.register(cellWithClass: SZPMallCell.self)
        let identifier = String(format: "SZPMallCell")  //
         
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = SZPMallCell.init(style: .default, reuseIdentifier: identifier)
        }
        tableView.separatorStyle = .none

        return cell! as! SZPMallCell
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.init(hexString: "#f2f2f2")
        selectionStyle = .none
        contentView.addSubview(itemView)
    
        itemView.addSubview(iconView)
        itemView.addSubview(nameLabel)
        itemView.addSubview(currentPriceLabel)
        itemView.addSubview(addCarBtn)
        itemView.addSubview(line)
    }

    private var tempGoodsID: String?

    func loadInfo(_ model: SZPCartGoodsItem, _ isSelected: Bool = false) {

        tempGoodsID = model.cartUUID

        if let img = model.coverUrl {
            iconView.kf.setImage(with: URL(string: img))
        }
        nameLabel.text = model.title
        currentPriceLabel.text = MAL_Price(model.price ?? "0")
        
        if(isVip()){
            
            currentPriceLabel.text = MAL_Price("\(model.vipPrice ?? "")")
           
        }else{
            
            currentPriceLabel.text = MAL_Price("\(model.price ?? "")")
                   
         }
        
   

    }
    override func layoutSubviews() {
        super.layoutSubviews()

        let offx = MAL_Value(15)
        let itemW = width
        itemView.frame = CGRect.init(x: 0, y: 0, width: itemW, height: height)
       // MAL_ViewBorderRadius(itemView, MAL_Value(10))
        iconView.frame = CGRect.init(x: offx, y: MAL_Value(15), width: MAL_Value(100), height: MAL_Value(100))
        iconView.centerY = itemView.height * 0.5

        let nameWidth = itemView.width - iconView.right - MAL_Value(12) - MAL_Value(10) - MAL_Value(20)
        let nameH = nameLabel.requiredHeight(nameWidth)
        nameLabel.frame = CGRect.init(x: iconView.right + MAL_Value(12), y: iconView.top + MAL_Value(5), width: nameWidth, height: nameH)
        
        addCarBtn.frame = CGRect.init(x: itemView.right - MAL_Value(30) - offx , y: iconView.top + MAL_Value(5), width:  MAL_Value(30), height:  MAL_Value(30))
        
     
     

        let priceH = MAL_Value(22)
        let priceWidth = currentPriceLabel.requiredWidth(priceH)
        let priceTop = iconView.bottom - MAL_Value(10) - priceH
        currentPriceLabel.frame = CGRect.init(x: nameLabel.left, y: priceTop, width: priceWidth, height: priceH)
        
        addCarBtn.centerY = currentPriceLabel.centerY

        line.snp.remakeConstraints { make in
        
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(7)
       
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var itemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColor.backgroundColorNormal
        return view
    }()
    
    private lazy var addCarBtn: UIButton = {
        let view = UIButton.init(type: .custom)

        view.setImage(MAL_ImageNamed("addCarBtn"), for: .normal)
        view.addTarget(self, action: #selector(p_clickAddCar(_:)), for: .touchUpInside)
        return view
    }()
    
    @objc private func p_clickAddCar(_ sender:UIButton){
        
        
    }


 

    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = MAL_ImageNamed("no_pic")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = MAL_Value(10)
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let view = UILabel.init(text: "课程名称课程名称课程名称课程名称课程名称")
        view.font = UIFont.szpAppleNormalFont(15)
        view.textColor  = UIColor.AppColor.titleColorLightBlack
        view.numberOfLines = 2
        return view
    }()
 
    private lazy var currentPriceLabel: UILabel = {
        let view = UILabel.init(text: MAL_Price("998"))
        view.font = UIFont.szpHelveticaFont(20)
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        return view
    }()
  
 
 
}

