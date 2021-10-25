//
//  MALRecommendedProductsView.swift
//  MallProject
//
//  Created by 张昭 on 2021/10/6.
//

import UIKit
///推荐产品ListView
class MALRecommendedProductsView: UIView {
    
    deinit {
        debugPrint("MALRecommendedProductsView销毁")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(courseView)
        courseView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var courseView: UICollectionView = {

        let view = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        // 高度自适应
        view.autoresizingMask = .flexibleHeight
        view.ly_emptyView = LYEmptyView.empty(withImageStr: "icon_no_data", titleStr: "暂时还没有数据".local, detailStr: "")
        return view
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = MAL_Value(10)
        flowLayout.minimumInteritemSpacing = MAL_Value(10)

        flowLayout.scrollDirection = .horizontal
        let space = MAL_Value(10)
        let cellW = MAL_Value(90)
        flowLayout.itemSize = CGSize.init(width: cellW, height: MAL_Value(162))
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: space, bottom: space, right: space)
        return flowLayout
    }()

}

extension MALRecommendedProductsView: UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = SZPHomtHotCourseCell.cellWithCollectionView(collectionView, indexpath: indexPath)
        
        cell.loadCell()
      
    
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pushVC = MALProductViewController()
        let currentVC = UIViewController.getTopViewController()
        currentVC?.navigationController?.pushViewController(pushVC)
        
        
        
    }
 
    
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    

}

class SZPHomtHotCourseCell: UICollectionViewCell {

    class func cellWithCollectionView(_ collectionView:UICollectionView, indexpath: IndexPath) -> SZPHomtHotCourseCell {

        collectionView.register(cellWithClass: SZPHomtHotCourseCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: SZPHomtHotCourseCell.self, for: indexpath)

        return cell
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.white
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
   
        
    }
  


    func loadCell(){
        
        let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:priceLabel.text ?? "")
        attrstring.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize:18), range: NSRange.init(location: 1, length: attrstring.length - 1))
        priceLabel.attributedText = attrstring
        
        layoutSubviews()
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let space = MAL_Value(5)
        
    
        iconView.frame = CGRect.init(x: space, y: 0, width: width, height: MAL_Value(110))
      
     
        let titleW = width - space
        let titleH = titleLabel.text?.heightWithConstrainedWidth(titleW, font: titleLabel.font)
        
        titleLabel.frame = CGRect.init(x: iconView.left, y: iconView.bottom, width: iconView.width, height:CGFloat(titleH ?? 0)  <= 40 ? CGFloat(titleH ?? 0) : MAL_Value(38))
       
        let priceH = MAL_Value(22)
        let priceW = priceLabel.text?.widthWithConstrainedHeight(priceH, font: priceLabel.font)
        priceLabel.frame = CGRect.init(x: iconView.left, y: titleLabel.bottom, width: width, height: priceH)
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = MAL_ImageNamed("pruc")
     
        return view
    }()


    private lazy var titleLabel: UILabel = {
        let view = UILabel.init(text: "商品标题商品标题商品标题商品标题商品标题商品标题商品标题商品标题商品标题")
        view.font = UIFont.szpAppleNormalFont(10)
        view.numberOfLines = 2
        view.textColor = UIColor.AppColor.titleColorLight
        return view
    }()
 
    private lazy var priceLabel: UILabel = {
        let view = UILabel.init(text: MAL_Price("30.00"))
        view.font = UIFont.szpHelveticaFont(12)
        view.textColor = UIColor.AppColor.homeCurrentPriceColor
        
      
        
        return view
    }()
    

    

}

class SZPHomeHotCourseHeader: UICollectionReusableView {

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
        view.contentHorizontalAlignment = .left
        return view
    }()
    
}

