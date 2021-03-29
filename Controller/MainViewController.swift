//
//  MainViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import UIKit

class MainViewController: UIViewController {
    
    var isNoFirst: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "color_theme")
                
        let titleLabel = UILabel()
        titleLabel.font = blodFontWithSize(25)
        titleLabel.textColor = UIColor(named: "color_title_black")
        titleLabel.text = "聚玩"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "user")?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightBtn.tintColor = UIColor(named: "color_title_black")
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)

    }
    
    func sebViews() {
   
    }
    
    @objc func rightBtnClick() {
        
    }
}
