//
//  Play2048ViewController.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

class Play2048ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        let navTipView = FZTipHeandView()
        self.view.addSubview(navTipView)
        navTipView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(84)
        }
        navTipView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backClick)))
    }
    
    @objc func backClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
