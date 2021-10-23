//
//  MALVideoPackageDetailBottomView.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/16.
//

import UIKit



/// 加入购物车,立即购买view
class MALVideoPackageDetailBottomView: UIView {
    


    deinit {
        
        debugPrint("MALVideoPackageDetailBottomView销毁")
    }
    
 
  
    
    

    enum KBottomActionType: Int {
        case actionOfService = 90001, // 客服
             actionOfCollect, // 收藏
             actionOfCollectCancel, // 取消收藏
             actionOfAddCart, // 加入购物车
             actionOfBuy      // 立即购买
    }
    //    var bottomActionBlock: ((_ type: KBottomActionType) -> Void)?
    //    var isEditAction:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white
    
         addSubview(addBTM)
         addSubview(buyBTM)
         szp_addCommonTopShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   override func layoutSubviews() {
       super.layoutSubviews()

        let offx = MAL_Value(30)
     
        addBTM.snp.remakeConstraints { (make) in
            make.top.equalTo(MAL_Value(10))
//            make.left.equalTo(collectBTN.snp.right).offset(CGFloat(30))
            make.width.equalTo(CGFloat(90))
            make.height.equalTo(CGFloat(35))
        }
        buyBTM.snp.makeConstraints { [unowned self] (make) in
            make.top.size.equalTo(addBTM)
            make.left.equalTo(addBTM.snp.right)
            make.right.equalTo(-offx/2)
        }

        addBTM.roundCorners([.topLeft, .bottomLeft], radius: CGFloat(35/2.0))
        buyBTM.roundCorners([.topRight, .bottomRight], radius: CGFloat(35/2.0))
    }



    private lazy var addBTM: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("加入购物车".local, for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.szpHelveticaFont(14)
        view.backgroundColor = UIColor.AppColor.main
    
        view.addTarget(self, action: #selector(p_clickActionBTN(_:)), for: .touchUpInside)
        view.tag = KBottomActionType.actionOfAddCart.rawValue
        return view
    }()
    private lazy var buyBTM: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("立即购买".local, for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.szpHelveticaFont(14)
        view.backgroundColor = UIColor.init(hexString: "#df0000")
        view.addTarget(self, action: #selector(p_clickActionBTN(_:)), for: .touchUpInside)
        view.tag = KBottomActionType.actionOfBuy.rawValue
        return view
    }()



 
    /// 标记：当前商品的type：1实战课程 2实战课程包 3线上课程 4直播课程 5直播课程包 6实地学习 7商品
    private var tempItemType: Int = 0
    /// 1实战课程  2案例图  3理论线上课程 4直播课程 5商品 6视频包
    private var isFavoritesTempType: Int = 0

    /// 标记：当前商品的UUID
    private var tempUUID: String?
    /// 标记：当前商品的property(type = 7时有值)
    private var tempProperty = ""
}

extension MALVideoPackageDetailBottomView {



    /// 商城商品详情：加载商品详情
    func loadMallInfo(_ mdoel: SZPMallDetailModel?) {
        guard let item = mdoel else { return }

     

    }

    
}
extension MALVideoPackageDetailBottomView {

    @objc func p_clickActionBTN(_ sender: UIButton) {

  
    }
    func handleAction(_ action: KBottomActionType) {

     
    }

    func actionAddCart(_ property:String?) {

   
    }
    func actionBuyNow(_ itemType: Int, _ goodsID: String, _ isGoodsPop:Bool = false) {
        
   
    }
    




 
    func actionService( _ goodsID: String) {
        // TODO: -售后客服
 

    }
    
 
    
}



