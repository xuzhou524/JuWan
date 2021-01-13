//
//  RankListTableViewCell.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/13.
//

import UIKit

class RankListTableViewCell: UITableViewCell {
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orange
        return imageView
    }()

    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(16)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "哈哈"
        return label
    }()

    let scoreLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "23,521"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.selectionStyle = .none;
        self.contentView.backgroundColor = UIColor(named: "color_theme")
        sebViews()
    }
    
    func sebViews() {

        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(scoreLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(33)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
    }

}

