//
//  PlayWatermelonViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import UIKit
import SwiftUI
import SpriteKit
import GameKit
import GameplayKit

class PlayWatermelonViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        let vc = UIHostingController(rootView: WatermelonView())
        self.view.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
                
        let navTipView = FZTipHeandView()
        self.view.addSubview(navTipView)
        navTipView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(84)
        }
        navTipView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backClick)))
  
        
    }
    
    func saveHighScore(s:NSInteger){
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "juWan_Watermelon")
            scoreReporter.value = Int64(s)
            GKScore.report([scoreReporter], withCompletionHandler: nil)
        }
    }
    
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

