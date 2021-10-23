//
//  MALMallCartViewController.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

///购物车VC
class MALMallCartViewController: MALBaseViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()

    
        cartListView.listView.reloadData()
        tempTopView.loadTitle("购物车",UIColor.white)
        
        view.addSubview(tempTopView)
        view.addSubview(cartListView)
        view.addSubview(bottomPayView)
        
        tempTopView.snp.remakeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
          
        }
       
        bottomPayView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-kTabBarHeight)
            make.height.equalTo(MAL_Value(48))
            make.width.equalToSuperview()
            
        }
        
        cartListView.snp.remakeConstraints { make in
            
            make.top.equalTo(tempTopView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomPayView.snp.top).offset(MAL_Value(-10))
            
        }
        

    }
 
    
    lazy var tempTopView: SZPNaView = {
        let view = SZPNaView.init(frame: .zero, viewType: .typeOfTitle)
        view.backgroundColor = UIColor.AppColor.main
        view.refreshBackIcon(icon: "nav_icon_back_white", title: "", cartIcon: "ic_nav_catalogue_shop", shareIcon: "nav_ic_share_y")
        view.alpha = 1
        return view
    }()
    
    private lazy var cartListView: MALMallCartListView = {
        let view = MALMallCartListView()
        return view
    }()
    
    private lazy var bottomPayView: SZPCartBottomView = {
        let view = SZPCartBottomView.init(frame: .zero)
        return view
    }()
    
  


}

enum KCartActionType {
    case typeOfAllSelect,
         typeOfNoSelect,
         typeOfPay,
         typeOfDelete
}

class SZPCartBottomView: UIView {

    var cartBottomActionBlock: ((_ type: KCartActionType) -> Void)?

    var isEditAction:Bool = false

    func refreshAllStateBTN (_ isAll: Bool) {
        selectAllBtn.isSelected = isAll
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white
        addSubview(selectAllBtn)
        addSubview(totalLabel)
        addSubview(priceLabel)
        addSubview(payBtn)
    }
    //是否能点击
    func isCanBtn(_ isDone: Bool = true){
        
        if(isDone == true){
     
            payBtn.isUserInteractionEnabled = true
           // payBtn.setBackgroundImage(MAL_ImageNamed("icon_btn_bj"), for: .normal)
            payBtn.setBackgroundImage(UIImage.init(color: UIColor.AppColor.main, size: CGSize(width: MAL_Value(118), height: MAL_Value(48))), for: .selected)
            
        }else{
           
            payBtn.isUserInteractionEnabled = false
            payBtn.setBackgroundImage(nil, for: .normal)
            payBtn.setBackgroundImage(nil, for: .selected)
            payBtn.backgroundColor = UIColor.init(hexColor: "#CCCCCC")
            
        }
        
        
        
    }

    func showEditUI(_ isEdit:Bool = false) {

        isEditAction = isEdit

        totalLabel.isHidden = isEdit
        priceLabel.isHidden = isEdit
        let payTitle = isEdit ? "删除".local : "去结算".local
        payBtn.setTitle(payTitle, for: .normal)
        payBtn.isSelected = isEdit
    }

    func loadSelectedPrice(_ money: Double) {
        
          let moneyStr = String(format: "%.2f", money)
        
        priceLabel.text = MAL_Price(moneyStr)
        layoutSubviews()
    }
    @objc private func p_clickPayBtn() {

        if cartBottomActionBlock != nil {
            let type =  isEditAction ? KCartActionType.typeOfDelete : KCartActionType.typeOfPay
            cartBottomActionBlock!(type)
        }
    }

    @objc func p_selectAllBtn(_  sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if cartBottomActionBlock != nil {

            let actionType = sender.isSelected ? KCartActionType.typeOfAllSelect : KCartActionType.typeOfNoSelect
            cartBottomActionBlock!(actionType)

        }
        if !sender.isSelected {
            priceLabel.text = MAL_Price("0")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let offx = MAL_Value(15)
        let itemH = MAL_Value(20)
        let selectBtnW =  selectAllBtn.titleLabel!.requiredWidth(itemH) + MAL_Value(20)
        selectAllBtn.frame = CGRect.init(x: offx, y: 0, width: selectBtnW, height: MAL_Value(20))
        selectAllBtn.hitTestEdgeInsets = UIEdgeInsets.init(top: MAL_Value(-10), left: MAL_Value(-20), bottom: MAL_Value(-10), right: MAL_Value(-10))
  
        let payW = MAL_Value(118)
        payBtn.frame = CGRect.init(x: width - payW, y: 0, width: payW, height: MAL_Value(48))
        selectAllBtn.centerY = payBtn.height * 0.5
      
        szp_addCommonTopShadow()
        
        let priceW = priceLabel.requiredWidth(MAL_Value(22))
        priceLabel.frame = CGRect.init(x:  payBtn.left - priceW - MAL_Value(10), y: 0, width: priceW, height: MAL_Value(22))
        
        let totalW = totalLabel.requiredWidth(MAL_Value(17))
        totalLabel.frame = CGRect.init(x: priceLabel.left - MAL_Value(10), y: 0, width: totalW, height: MAL_Value(17))
        totalLabel.centerY = payBtn.height * 0.5
        priceLabel.centerY = payBtn.height * 0.5
        totalLabel.right =  payBtn.left - priceW - MAL_Value(15)
     
        
    }

    private lazy var selectAllBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("全选".local, for: .normal)
        view.setTitleColor(UIColor.AppColor.lightGrayColor, for: .normal)
        view.titleLabel?.font = UIFont.szpAppleBoldFont(13)
        view.setImage(MAL_ImageNamed("radio_n"), for: .normal)
        view.setImage(MAL_ImageNamed("radio_s"), for: .selected)
        view.addTarget(self, action: #selector(p_selectAllBtn(_:)), for: .touchUpInside)
        view.contentHorizontalAlignment = .left
        view.setTitleSpace(MAL_Value(5))

        return view
    }()

    private lazy var totalLabel: UILabel = {
        let view = UILabel.init(text: "合计:".local)
        view.font = UIFont.szpAppleNormalFont(15)
        view.textColor = UIColor.AppColor.titleColorLightBlack
        view.textAlignment = .right
        return view
    }()
    private lazy var priceLabel: UILabel = {
        let view = UILabel.init(text: MAL_Price("0"))
        view.font = UIFont.szpHelveticaFont(16)
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        view.textAlignment = .left
        return view
    }()
     lazy var payBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("结算".local, for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.szpHelveticaFont(15)
    
        view.setBackgroundImage(UIImage.init(color: UIColor.AppColor.main, size: CGSize(width: MAL_Value(118), height: MAL_Value(48))), for: .normal)
        view.addTarget(self, action: #selector(p_clickPayBtn), for: .touchUpInside)
        return view
    }()

}



