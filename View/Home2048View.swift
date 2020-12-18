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
        label.font = fontWithSize(30)
        label.textColor = UIColor(named: "color_white")
        label.text = "2048"
        return label
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
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(25)
        }
     }

}
