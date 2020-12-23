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
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(30)
        label.textColor = UIColor(named: "color_white")
        label.text = "2048"
        return label
    }()
    
    let globalButton:UIButton = {
        let button = UIButton()
        button.setTitle("全球排行榜", for: .normal)
        button.setTitleColor(UIColor(named: "color_white"), for: .normal)
        button.titleLabel?.font = blodFontWithSize(18)
        button.setBackgroundImage(UIColor.clear.image, for: .normal)
        return button
    }()
    
    let tipButton:UIButton = {
        let button = UIButton()
        button.setTitle("PLAY", for: .normal)
        button.setTitleColor(UIColor(named: "color_black"), for: .normal)
        button.titleLabel?.font = blodFontWithSize(20)
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
        self.addSubview(tipButton)
        self.addSubview(globalButton)
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(25)
        }
        
        tipButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
        
        globalButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(25)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
     }

}
