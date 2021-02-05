//
//  CDViewCell.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

class CDViewCell: UICollectionViewCell {
    
    let selectView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    let goodsImg:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(16)
        label.textColor = UIColor(named: "color_black")
        label.text = "经典"
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_black")
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
        
        self.contentView.addSubview(selectView)
        self.contentView.addSubview(goodsImg)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        
        selectView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
        }
    
        goodsImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo((kScreenWidth - 60) * 3 / 5)
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
