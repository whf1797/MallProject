//
//  MALBannerScrollView.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

enum KScrollBannerType: Int {
    case typeOfHome,
         typeOfCategory,
         typeOfProduct,
         typeOfMall,
         typeOfDetail // 视频（课程）详情
}

class MALBannerScrollView : UIView  {


//    let urls = ["http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171101181927887.jpg",
//                "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114171645011.jpg",
//                "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114172009707.png"]
//
//    let images = [UIImage(named: "p700-300-1"),
//                  UIImage(named: "p700-300-2"),
//                  UIImage(named: "p700-300-3"),
//                  UIImage(named: "p700-300-4"),
//                  UIImage(named: "p700-300-5")]

    private var tempBanenrList: [Any]? {
        didSet {

            if let allCount = tempBanenrList?.count, allCount > 0 {

                pageLabel.text = "\(1)/\(allCount)"

                cycleView1.reloadItemsCount(allCount)
                cycleView1.snp.remakeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            } else {
                pageLabel.text = "1/1"
            }
        }
    }

    public func loadBannerList(_ list:[SZPBannerItem]?) {

        tempBanenrList = list
    }
    public func loadImageList(_ urlList: [String]?) {

        tempBanenrList = urlList
    }

    /// item大小
    public var itemSize: CGSize? {
        didSet {
            guard let itemSize = itemSize else { return }
            cycleView1.itemSize = itemSize
        }
    }
    public var isHidePageControl: Bool = false
    public var isHidePageLabel: Bool = true
    public var isHomeView: Bool = false

    public var itemZoomScale: CGFloat? {
        didSet {
            guard let sale = itemZoomScale else { return  }
            cycleView1.itemZoomScale = sale
        }
    }

//    /// Block：Banner 点击跳转的连接是
//    var clickItemBlock:((_ linkUrl: String?) -> Void)?

    private var tempType = KScrollBannerType.typeOfHome
    init(frame: CGRect, type: KScrollBannerType) {
        super.init(frame: frame)

        tempType = type
        isHomeView = false
        switch type {
        case .typeOfHome:
                isHomeView = true
                cycleView1.itemSize = CGSize(width: kScreenWidth, height: MAL_Value(170))
//                cycleView1.itemZoomScale = 1.0
                cycleView1.itemSpacing = MAL_Value(10)
        case .typeOfCategory:
            cycleView1.itemSize = CGSize(width: MAL_Value(250), height: MAL_Value(90))
            cycleView1.itemSpacing = MAL_Value(15)
        case .typeOfMall:
                cycleView1.itemSize = CGSize(width: kScreenWidth - MAL_Value(30), height: MAL_Value(114))
                cycleView1.itemSpacing = MAL_Value(15)
        case .typeOfDetail:
                cycleView1.itemSize = CGSize(width: kScreenWidth - MAL_Value(30), height: MAL_Value(60))
                cycleView1.itemSpacing = MAL_Value(15)
        case .typeOfProduct:
                cycleView1.itemSize = CGSize.init(width: kScreenWidth, height: MAL_Value(375))
                isHidePageControl = true
                isHidePageLabel = false
                cycleView1.itemSpacing = MAL_Value(5)
        }

//        backgroundColor = UIColor.AppColor.searchBgColor
        addSubview(cycleView1)
        addSubview(pageLabel)

        cycleView1.placeholderImage = MAL_ImageNamed("no_pic")
        cycleView1.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        pageLabel.isHidden = isHidePageLabel
        if !isHidePageLabel {
            pageLabel.snp.makeConstraints { (make) in
                make.right.equalTo(MAL_Value(-15))
                make.width.equalTo(MAL_Value(50))
                make.height.equalTo(MAL_Value(20))
                make.bottom.equalToSuperview().offset(MAL_Value(-15))
                MAL_ViewBorderRadius(pageLabel, MAL_Value(10))
            }
        }
        if let list = tempBanenrList, list.isEmpty == false {
            pageLabel.text = "1/\(list.count)"
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = cycleView1.frame
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        cycleView1.frame = frame
    }

    private lazy var cycleView1: ZCycleView = {
        let cycleView1 = ZCycleView()
        cycleView1.placeholderImage = MAL_ImageNamed("no_pic")
        cycleView1.scrollDirection = .horizontal
        cycleView1.delegate = self
        cycleView1.reloadItemsCount(1)
//        cycleView1.itemZoomScale = 1.2
        cycleView1.itemSpacing = MAL_Value(0)
        cycleView1.initialIndex = 0
//        cycleView1.isAutomatic = false
//        cycleView1.isInfinite = false
//        cycleView1.itemSize = CGSize(width: width - MAL_Value(30), height: MAL_Value(114))
       
        return cycleView1
    }()
    lazy var pageLabel: UILabel = {
        let view = UILabel.init(text: "")
        view.backgroundColor = UIColor.AppColor.alertBackgroundColor
        view.font = UIFont.szpAppleNormalFont(13)
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.isHidden = true
        return view
    }()
}
import SafariServices
extension MALBannerScrollView: ZCycleViewProtocol {

    func cycleViewRegisterCellClasses() -> [String: AnyClass] {
        if isHomeView {
            return ["SZPHomeBannerCell": SZPHomeBannerCell.self]
        } else {
            return ["SZPMallBannerCell": SZPMallBannerCell.self]
        }
    }

    func cycleViewConfigureCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, realIndex: Int) -> UICollectionViewCell {
        if isHomeView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SZPHomeBannerCell", for: indexPath) as! SZPHomeBannerCell
            if tempBanenrList?.isEmpty == false {

                guard let item = tempBanenrList?[realIndex] as? SZPBannerItem else { return cell }
                cell.imageView.kf.setImage(with: URL(string: item.bannerUrl))
              
            }
            
            return cell
        } else {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SZPMallBannerCell", for: indexPath) as! SZPMallBannerCell
            if isHidePageLabel {
                MAL_ViewBorderRadius(cell.imageView, MAL_Value(5))
            }

            if tempBanenrList?.isEmpty == false {

                let item = tempBanenrList![realIndex]
                let itemType = type(of: item)
                if itemType == SZPBannerItem.self {

                    cell.imageView.kf.setImage(with: URL(string: (item as! SZPBannerItem).bannerUrl))
                } else if itemType == String.self {

                    cell.imageView.kf.setImage(with: URL(string: item as! String))
                } else if itemType == UIImage.self {
                    cell.imageView.image = (item as! UIImage)
                }
            }
            return cell
        }
    }
    func cycleViewDidSelectedIndex(_ cycleView: ZCycleView, index: Int) {

        guard let item = (tempBanenrList?[index] as? SZPBannerItem) else { return  }


      
    }
    func cycleViewDidScrollToIndex(_ cycleView: ZCycleView, index: Int) {

        if !isHidePageLabel {
            let allCount = tempBanenrList?.count
            pageLabel.text = "\(index + 1)/\(allCount ?? 1)"
        }
    }

    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {

        pageControl.isHidden = isHidePageControl
        pageControl.currentPageIndicatorTintColor = UIColor.init(hexColor: "#e0b268", alpha: 0.5)
        pageControl.pageIndicatorTintColor = UIColor.init(hexColor: "#c8c8c8", alpha: 1)
        pageControl.snp.remakeConstraints { (make) in
            make.left.width.equalTo(cycleView)
            make.height.equalTo(MAL_Value(10))
            make.bottom.equalTo(cycleView).offset(MAL_Value(-10) )
        }
    }
}

class SZPHomeBannerCell: UICollectionViewCell {

    lazy var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

//        let space = MAL_Value(0)
//        imageView.frame = CGRect.init(x: space, y: 0, width: contentView.bounds.width - space * 2, height: contentView.bounds.height)
        contentView.addSubview(imageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
   
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SZPMallBannerCell: UICollectionViewCell {

    lazy var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.frame = self.bounds
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
