//
//  AccessoryViews.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/4/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import UIKit

protocol ScoreViewProtocol {
    func scoreChanged(newScore s: Int)
}

class Score2048View: UIView,ScoreViewProtocol {
    var score : Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_white")
        label.text = "得分"
        return label
    }()
    
    let scoreLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(28)
        label.textColor = UIColor(named: "color_title_white")
        label.text = "0"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "color_title_black")
        self.layer.cornerRadius = 10
        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(nameLabel)
        self.addSubview(scoreLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-8)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(-8)
        }
        
    }
    
    func scoreChanged(newScore s: Int)  {
        score = s
    }
}
