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
    
    let oneView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_white")
        view.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: 80, height: 130))
        return view
    }()
    
    let oneImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "one")
        return imageView
    }()
    
    let twoView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_white")
        view.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: 80, height: 110))
        return view
    }()
    let twoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "two")
        return imageView
    }()
    
    let threeView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_white")
        view.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: 80, height: 90))
        return view
    }()
    let threeImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "three")
        return imageView
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
            make.centerY.equalToSuperview().offset(-60)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
        
        globalButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipButton.snp.bottom).offset(50)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
        
        self.addSubview(oneView)
        self.addSubview(oneImageView)
        oneView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(130)
            make.width.equalTo(80)
        }
        
        oneImageView.snp.makeConstraints { (make) in
            make.top.equalTo(oneView.snp.top)
            make.centerX.equalTo(oneView)
            make.height.equalTo(30)
            make.width.equalTo(43.5)
        }
        
        self.addSubview(twoView)
        self.addSubview(twoImageView)
        twoView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalTo(oneView.snp.left).offset(-20)
            make.height.equalTo(110)
            make.width.equalTo(80)
        }
        twoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(twoView.snp.top)
            make.centerX.equalTo(twoView)
            make.height.equalTo(30)
            make.width.equalTo(43.5)
        }
        
        self.addSubview(threeView)
        self.addSubview(threeImageView)
        threeView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(oneView.snp.right).offset(20)
            make.height.equalTo(90)
            make.width.equalTo(80)
        }
        threeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(threeView.snp.top)
            make.centerX.equalTo(threeView)
            make.height.equalTo(30)
            make.width.equalTo(43.5)
        }
    }
}
