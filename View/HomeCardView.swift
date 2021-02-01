//
//  HomeCardView.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

class HomeCardView: UIView {
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "2048bg")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(22)
        label.textColor = UIColor(named: "color_white")
        label.text = "数和"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_white")
        label.text = "回顾经典玩法，挑战全球排行"
        return label
    }()
    
    let rulesLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(12)
        label.alpha = 0.8
        label.numberOfLines = 0
        label.textColor = UIColor(named: "color_white")
        label.text = "规则：上下左右滑动两个相同数字方块撞在一起之后合并成为他们的和，直到无法移动，所有和相加即为本局分数"
        return label
    }()
    
    let starImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_starThree")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "color_white")
        return imageView
    }()
    
    let tipButton:UIButton = {
        let button = UIButton()
        button.setTitle("开始挑战", for: .normal)
        button.setTitleColor(UIColor(named: "color_black"), for: .normal)
        button.titleLabel?.font = blodFontWithSize(18)
        button.setBackgroundImage(UIColor(named: "color_white")?.image, for: .normal)
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(bgImageView)
        self.addSubview(titleLabel)
        self.addSubview(summeryLabel)
        self.addSubview(rulesLabel)
        self.addSubview(tipButton)
        self.addSubview(starImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.bottom.right.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(35)
        }
        
        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        rulesLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        tipButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalTo(rulesLabel.snp.top).offset(-15)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
        
        starImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-35)
            make.width.equalTo(50)
            make.height.equalTo(15.4)
        }
    }
}
