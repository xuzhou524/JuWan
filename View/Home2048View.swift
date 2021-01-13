//
//  Home2048View.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

class Home2048View: UIView {
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "2048bg")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(30)
        label.textColor = UIColor(named: "color_white")
        label.text = "2048"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(15)
        label.textColor = UIColor(named: "color_white")
        label.text = "回顾经典2048，挑战全球排行"
        return label
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
        self.addSubview(tipButton)
        
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
        
        tipButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
    }
}
