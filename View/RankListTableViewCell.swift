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
            make.left.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(33)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
        }
    }
}

class RankHeadView: UIView {
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(20)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "全球排行榜"
        return label
    }()
    
    let bgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_title_black")
        view.alpha = 0.3
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let rankLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "名次"
        return label
    }()

    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "用户名"
        return label
    }()

    let scoreLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "积分值"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "color_theme")
        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(titleLabel)
        
        self.addSubview(bgView)
        
        self.addSubview(rankLabel)
        self.addSubview(nameLabel)
        self.addSubview(scoreLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        rankLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(15)
            make.centerY.equalTo(bgView)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rankLabel.snp.right).offset(15)
            make.centerY.equalTo(bgView)
        }

        scoreLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-15)
            make.centerY.equalTo(bgView)
        }
    }
}
