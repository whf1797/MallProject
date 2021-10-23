//
//  SZPMallCartSubviews.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/10.

import UIKit

class MALMallCartSubviews: UIView {

}

class MALMallCartListView: UIView {
    
    public var isSelectAll:Bool = false {
        didSet {
            tempSelectItems.removeAll()
            listView.reloadData()
        }
    }
  

    /// Block：选中所有商品
    var selectAllStateBlock: ( (_ isAll: Bool, _ count: Int) -> Void )?

    /// 修改购物车商品数量
    var changeItemContBlock: ((_ isAdd: Bool, _ goodsID: String?) -> Void)?

    /// Block: 删除无效商品
    var deleteInvalGoodsBlock: (() -> Void)?
    
    private var tempListViewHeightConstraint: CGFloat = 0
    private var tempSelectItems:[IndexPath] = [IndexPath]() {
        didSet {
            let isAll = tempSelectItems.count == cartInfo?.validList.count
            guard let block = selectAllStateBlock else { return }
            block(isAll,tempSelectItems.count)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(listView)
      
        listView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private var cartInfo: SZPCartModel?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
extension MALMallCartListView {
 
    /// 获取内容高度
    func getListHeight() -> CGFloat {

        let validCount = cartInfo?.validList.count ?? 0
        let itemH = CGFloat(validCount) * MAL_Value(120)
        return itemH
    }

    /// 获取到商品的id
    func getSelectGoodsIDs() -> String {
        var goodids = ""
        if let cartList = cartInfo?.validList, tempSelectItems.isEmpty == false {

            _ = tempSelectItems.filter { (index) -> Bool in
                let item = cartList[index.row]
                if let id = item.cartUUID {
                    goodids += ",\"\(id)\""
                }
                return true
            }
            goodids.removeFirst()
            goodids = String(format: "[%@]", goodids)
        }
        return goodids
    }
    /// 获取当前选择的商品列表
    func getSelectItems() -> [SZPCartGoodsItem] {

        var tempArr = [SZPCartGoodsItem]()
        let cartList = cartInfo?.validList
        _ = tempSelectItems.filter { (index) -> Bool in
            if let item = cartList?[index.row] {
                tempArr.append(item)
            }
            return true
        }
        return tempArr
    }

    /// 获取到商品的价格
    func getSelectedGoodsPrice() -> Double {
        var money = Double(0)
        let cartList = cartInfo?.validList
        _ = tempSelectItems.filter { (index) -> Bool in
            let item = cartList?[index.row]
            if let price = isVip() ? Double(item?.vipPrice ?? "0")   : Double(item?.price ?? "0"), let count = item?.quantity?.int {
                money += price * Double(count)
            }
            return true
        }
        return money
    }
}
extension MALMallCartListView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
 
            return 1
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
       // return cartInfo?.validList.count ?? 0
        return 10

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MAL_Value(120)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? MAL_Value(44) : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UITableViewHeaderFooterView()
            let headerView = SZPMallCartInvalHeaderView()
            headerView.clickDeleteBlock = deleteInvalGoodsBlock
            view.addSubview(headerView)
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

  

            let cell = SZPMallCartCell.cellWithTableView(tableView)
            cell.changeItemSelectedBlock = { [self] (select) in
                if tempSelectItems.contains(indexPath) {
                    tempSelectItems = tempSelectItems.filter({ (index) -> Bool in
                        return index != indexPath
                    })
                } else {
                    
                    
                    tempSelectItems.append(indexPath)
                    
                    
                }
            }
            cell.changeItemCountBlock = changeItemContBlock

            if let model = cartInfo?.validList[indexPath.row] {
                cell.loadInfo(model, isSelectAll)
            }
            if isSelectAll {
                tempSelectItems.append(indexPath)
            }
            return cell
        
    }
}

/// 商城购物车Cell
class SZPMallCartCell: UITableViewCell {


    var changeItemSelectedBlock: ( (_ selectedState: Bool) -> Void )?
    var changeItemCountBlock: ( (_ isAdd: Bool, _ goodsID: String?) -> Void )?


    class func cellWithTableView(_ tableView:UITableView) -> SZPMallCartCell {

        tableView.register(cellWithClass: SZPMallCartCell.self)
        let identifier = String(format: "SZPMallCartCell")  //
         
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = SZPMallCartCell.init(style: .default, reuseIdentifier: identifier)
        }
        tableView.separatorStyle = .none

        return cell! as! SZPMallCartCell
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.init(hexString: "#f2f2f2")
        selectionStyle = .none
        contentView.addSubview(itemView)
        itemView.addSubview(selectIconBtn)
        itemView.addSubview(iconView)
        itemView.addSubview(nameLabel)
        itemView.addSubview(deletedBtn)
        itemView.addSubview(currentPriceLabel)
        itemView.addSubview(reduceBtn)
        itemView.addSubview(countLabel)
        itemView.addSubview(increaseBtn)
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
        
        
        countLabel.text = model.quantity
        selectIconBtn.isSelected = isSelected

    }
    override func layoutSubviews() {
        super.layoutSubviews()

        let offx = MAL_Value(15)
        let itemW = width
        itemView.frame = CGRect.init(x: 0, y: 0, width: itemW, height: height)
       // MAL_ViewBorderRadius(itemView, MAL_Value(10))

        let tagWH = MAL_Value(20)
        selectIconBtn.frame = CGRect.init(x: offx, y: 0, width: tagWH, height: itemView.height)
        selectIconBtn.hitTestEdgeInsets = UIEdgeInsets.init(top: 0, left: MAL_Value(-20), bottom: 0, right: MAL_Value(-10))
        selectIconBtn.centerY = itemView.height * 0.5

        iconView.frame = CGRect.init(x: selectIconBtn.right + MAL_Value(10), y: MAL_Value(15), width: MAL_Value(85), height: MAL_Value(85))
        iconView.centerY = itemView.height * 0.5

        let nameWidth = itemView.width - iconView.right - MAL_Value(12) - MAL_Value(10) - MAL_Value(20)
        let nameH = nameLabel.requiredHeight(nameWidth)
        nameLabel.frame = CGRect.init(x: iconView.right + MAL_Value(12), y: iconView.top, width: nameWidth, height: nameH)
        deletedBtn.frame = CGRect(x: itemW - MAL_Value(10) - MAL_Value(15), y: 0, width: MAL_Value(15), height: MAL_Value(17))
        
        deletedBtn.centerY = nameLabel.centerY

        let priceH = MAL_Value(22)
        let priceWidth = currentPriceLabel.requiredWidth(priceH)
        let priceTop = iconView.bottom - MAL_Value(4) - priceH
        currentPriceLabel.frame = CGRect.init(x: nameLabel.left, y: priceTop, width: priceWidth, height: priceH)

        let btnWH = MAL_Value(18)
        increaseBtn.frame = CGRect(x: itemW - MAL_Value(10) - btnWH, y: 0, width: btnWH, height: btnWH)
        increaseBtn.centerY = currentPriceLabel.centerY

        let countW = countLabel.requiredWidth(btnWH) + MAL_Value(20)
        countLabel.frame = CGRect(x: increaseBtn.left - MAL_Value(5) - countW, y: increaseBtn.top, width: countW, height: btnWH)
        reduceBtn.frame = CGRect(x: countLabel.left - MAL_Value(5) - btnWH, y: increaseBtn.top, width: btnWH, height: btnWH)
        
        line.snp.remakeConstraints { make in
        
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            
            
            
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
        view.backgroundColor = UIColor.AppColor.cellLineColor
        return view
    }()
    
    private lazy var deletedBtn: UIButton = {
        let view = UIButton.init(type: .custom)

        view.setImage(MAL_ImageNamed("delCarItem"), for: .normal)
        view.addTarget(self, action: #selector(p_clickDel(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var selectIconBtn: UIButton = {
        let view = UIButton.init(type: .custom)

        view.setImage(MAL_ImageNamed("radio_n"), for: .normal)
        view.setImage(MAL_ImageNamed("radio_s"), for: .selected)
        view.isSelected = false
        view.addTarget(self, action: #selector(p_clickSelectIcon(_:)), for: .touchUpInside)
        return view
    }()
    private lazy var reduceBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.contentMode = .left
        view.setTitle("-", for: .normal)
        view.backgroundColor = UIColor.init(hexString: "f2f2f2")
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        
        view.addTarget(self, action: #selector(p_clickReduceIcon(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var increaseBtn: UIButton = {
        let view = UIButton.init(type: .custom)

        view.setTitle("+", for: .normal)
        view.addTarget(self, action: #selector(p_clickIncreaseIcon(_:)), for: .touchUpInside)
        view.backgroundColor = UIColor.init(hexString: "f2f2f2")
        view.setTitleColor(UIColor.AppColor.titleColorLight, for: .normal)
        return view
    }()

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
    private lazy var countLabel: UILabel = {
        let view = UILabel.init(text: "0")
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor.AppColor.titleColorLight
        view.textAlignment = .center
        view.backgroundColor = UIColor.init(hexString: "f2f2f2")
       
        return view
    }()
    private lazy var currentPriceLabel: UILabel = {
        let view = UILabel.init(text: MAL_Price("998"))
        view.font = UIFont.szpHelveticaFont(16)
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        return view
    }()
    @objc private func p_clickSelectIcon(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
        guard let block = changeItemSelectedBlock else { return }
        block(sender.isSelected)
    }
    @objc private func p_clickReduceIcon(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected

        guard let block = changeItemCountBlock else { return }
        block(false, tempGoodsID)
    }
    
    @objc private func p_clickDel(_ sender:UIButton){
        
        
    }
    
    @objc private func p_clickIncreaseIcon(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected

        guard let block = changeItemCountBlock else { return }
        block(true, tempGoodsID)
    }
}

/// 商城购物车：失效宝贝Cell
class SZPMallCartLoseCell: UITableViewCell {
    class func cellWithTableView(_ tableView:UITableView) -> SZPMallCartLoseCell {

        tableView.register(cellWithClass: SZPMallCartLoseCell.self)
        let identifier = String(format: "SZPMallCartLoseCell")
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = SZPMallCartLoseCell.init(style: .default, reuseIdentifier: identifier)
        }
        tableView.separatorStyle = .none

        return cell! as! SZPMallCartLoseCell
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.AppColor.searchBgColor
        selectionStyle = .none
        contentView.addSubview(itemView)
        itemView.addSubview(stateLabel)
        itemView.addSubview(iconView)
        itemView.addSubview(nameLabel)
        itemView.addSubview(tipLabel)
    }

 
    override func layoutSubviews() {
        super.layoutSubviews()

        let offx = MAL_Value(15)
        let itemW = width - offx * 2

//        itemView.snp.remakeConstraints { (make) in
//            make.left.equalTo(offx)
//            make.top.equalTo(MAL_Value(1))
//            make.width.equalTo(itemW)
//            make.bottom.equalToSuperview()
//        }
        itemView.frame = CGRect.init(x: offx, y:10, width: itemW, height: height - 1)
        
        stateLabel.text = "失效"
        tipLabel.text = "宝贝已不能购买"

        let stateH = MAL_Value(16)
        let stateW = stateLabel.requiredWidth(stateH) + MAL_Value(10)
        stateLabel.frame = CGRect.init(x: MAL_Value(10), y: 0, width: stateW, height: stateH)
        stateLabel.centerY = itemView.height * 0.5
        MAL_ViewBorderRadius(stateLabel, stateH / 2)
        
        
        

        iconView.snp.remakeConstraints { (make) in
            make.left.equalTo(stateLabel.snp.right).offset(5)
            make.top.equalTo(15)
            make.width.height.equalTo(MAL_Value(90))
            //MAL_ViewBorderRadius(iconView, MAL_Value(10))
            make.bottom.equalToSuperview().offset(MAL_Value(-10))
        }
        

        let nameWidth = itemView.width - MAL_Value(90) - stateW - MAL_Value(10) - MAL_Value(13) - MAL_Value(10)
        let nameH = nameLabel.requiredHeight(nameWidth)
        nameLabel.frame = CGRect.init(x: MAL_Value(90) + MAL_Value(10) + stateW  + MAL_Value(13), y: 15, width: nameWidth, height: nameH)

        let priceH = MAL_Value(22)
        tipLabel.frame = CGRect.init(x: nameLabel.left, y: 15 + MAL_Value(90)  - priceH, width: nameWidth, height: priceH)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var itemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = MAL_ImageNamed("no_pic")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = MAL_Value(10)
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let view = UILabel.init(text: "课程名称课程名称课程名称课程名称课程名称")
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textColor  = UIColor.AppColor.titleColorNormal
        view.numberOfLines = 2
        return view
    }()
    private lazy var stateLabel: UILabel = {
        let view = UILabel.init(text: "失效".local)
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor  = UIColor.white
        view.backgroundColor = UIColor.AppColor.lightGrayColor
        view.textAlignment = .center
        return view
    }()
    private lazy var tipLabel: UILabel = {
        let view = UILabel.init(text: "宝贝已不能购买".local)
        view.font = UIFont.szpAppleNormalFont(14)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        return view
    }()

}

/// 失效宝贝headerView
class SZPMallCartInvalHeaderView: UIView {

    var clickDeleteBlock: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.AppColor.searchBgColor
        addSubview(view)
        view.addSubview(tipLabel)
        view.addSubview(countLabel)
        view.addSubview(deleteButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 
    override func layoutSubviews() {
        super.layoutSubviews()

        let itemH = self.height
        let tipW = tipLabel.requiredWidth(itemH)
        view.frame = CGRect(x: MAL_Value(15), y: MAL_Value(10), width: kScreenWidth - MAL_Value(30), height: height)
        view.roundCorners([.topLeft, .topRight], radius: MAL_Value(10))

        tipLabel.frame = CGRect(x: MAL_Value(15), y: 0, width: tipW, height: itemH)
        countLabel.frame = CGRect(x: tipLabel.right, y: 0, width: MAL_Value(50), height: itemH)

        let deleteW = deleteButton.titleLabel!.requiredWidth(itemH)
        deleteButton.frame = CGRect(x: view.width - MAL_Value(10) - deleteW , y: 0, width: deleteW, height: itemH)
    }
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var tipLabel: UILabel = {
        let view = UILabel.init(text: "失效宝贝".local)
        view.font = UIFont.szpAppleNormalFont(16)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        return view
    }()
    lazy var countLabel: UILabel = {
        let view = UILabel.init(text: "1件")
        view.font = UIFont.szpAppleNormalFont(16)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        return view
    }()
    lazy var deleteButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("清空失效宝贝".local, for: .normal)
        view.setTitleColor(UIColor.AppColor.main, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(12)
        view.backgroundColor = UIColor.white
        view.addTarget(self, action: #selector(p_clickDeleteButton), for: .touchUpInside)
        return view
    }()
    @objc private func p_clickDeleteButton() {
        guard let block = clickDeleteBlock else { return }
        block()
    }

}



class SZPMallCartGuessHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.AppColor.searchBgColor
        addSubview(line)
        addSubview(tipButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        line.frame = CGRect(x: 0, y: 0, width: kScreenWidth - MAL_Value(190), height: 0.5)
        line.addShadow(ofColor: UIColor.AppColor.homeCurrentPriceColor, radius: 0, offset: CGSize(width: 0, height: 0.5), opacity: 1)
        tipButton.frame = CGRect(x: 0, y: 0, width: MAL_Value(70), height: MAL_Value(22))
        line.center = self.center
        tipButton.center = self.center
    }
    private lazy var tipButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor = UIColor.AppColor.searchBgColor
        view.setTitle("猜你喜欢".local, for: .normal)
        view.setTitleColor(UIColor.AppColor.titleColorLightBlack, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleNormalFont(11)
        view.setImage(MAL_ImageNamed("icon_like"), for: .normal)
        view.contentHorizontalAlignment = .center
        view.setTitleSpace(MAL_Value(5))
        return view
    }()
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColor.homeCurrentPriceColor
        return view
    }()
}
