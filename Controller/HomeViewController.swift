//
//  HomeViewController.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        let titleLabel = UILabel()
        titleLabel.font = fontWithSize(30)
        titleLabel.textColor = UIColor(named: "color_title_black")
        titleLabel.text = "聚玩"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(44 + 10)
            make.left.equalToSuperview().offset(25)
        }
        
        let view2048 = Home2048View()
        view2048.layer.cornerRadius = 10
        view2048.layer.masksToBounds = true
        self.view.addSubview(view2048)
        view2048.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.height.equalTo((kScreenWidth - 50) * 0.56)
        }
    }
}
