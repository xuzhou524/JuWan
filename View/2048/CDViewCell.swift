//
//  CDViewCell.swift
//  Card_hjw
//
//  Created by hejianwu on 16/10/26.
//  Copyright © 2016年 ShopNC. All rights reserved.
//

import UIKit

class CDViewCell: UICollectionViewCell {
    
    let goodsImg:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orange
        return imageView
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(16)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "经典"
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(15)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "无门槛"
        return label
    }()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
        
        sebViews()
    }
    
    func sebViews() {
        
        self.contentView.addSubview(goodsImg)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        
        goodsImg.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo((kScreenWidth - 40) * 3 / 5)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(goodsImg.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
