//
//  MainViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import UIKit
import GameKit
import GameplayKit

class MainViewController: UIViewController,GKGameCenterControllerDelegate {
    
    var isNoFirst: Bool = true

    let emptyView:EmptyCell = {
        let view = EmptyCell()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authenticateLocalPlayer()
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
        
        let viewWatermelon = HomeCardView()
        viewWatermelon.layer.cornerRadius = 10
        viewWatermelon.layer.masksToBounds = true
        viewWatermelon.tipButton.addTarget(self, action: #selector(watermelonTapped), for: .touchUpInside)
        viewWatermelon.tipButton.setTitle("玩一下", for: .normal)
        viewWatermelon.frame = CGRect(x: 0, y: 0 , width: kScreenWidth, height: 230)
        
        viewWatermelon.bgImageView.image = UIImage(named: "ic_Watermelon")
        viewWatermelon.titleLabel.text = "我要吃瓜"
        viewWatermelon.summeryLabel.text = "休闲吃瓜，挑战全球排行"
        viewWatermelon.rulesLabel.text = "规则：两个体型较小的水果相撞即可合成更大的水果，最终得到想吃的瓜"
        viewWatermelon.starImageView.image = UIImage(named: "ic_starTwo")?.withRenderingMode(.alwaysTemplate)
        
        self.view.addSubview(viewWatermelon)
        
        let viewShuHe = HomeCardView()
        viewShuHe.layer.cornerRadius = 10
        viewShuHe.layer.masksToBounds = true
        viewShuHe.tipButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        viewShuHe.tipButton.setTitle("玩一下", for: .normal)
        viewShuHe.frame = CGRect(x: 0, y: 230, width: kScreenWidth, height: 230)
        
        self.view.addSubview(viewShuHe)
        
    }
    
    func sebWithoutAuthorizationViews() {
        self.view.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
    }
    
    @objc func startGameButtonTapped() {
        let v = HomeViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @objc func watermelonTapped() {
        let v = WatermelonViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }

    @objc func globalButtonTapped() {
        let gameCenterVC = GKGameCenterViewController()
        gameCenterVC.gameCenterDelegate = self
        self.present(gameCenterVC, animated: true, completion: nil)
    }
    
    @objc func rightBtnClick() {
        if GameUserInfoConfig.shared.gameId.count > 0 {
            self.navigationController?.pushViewController(UserViewController(), animated: true)
        }else{
            self.navigationController?.pushViewController(HelpViewController(), animated: true)
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
}

extension MainViewController {
    func authenticateLocalPlayer(){
        if isNoFirst {
            isNoFirst = false
            self.showloading()
        }
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            self.hideLoading()
            if (viewController != nil) {
                let vc: UIViewController = self.view!.window!.rootViewController!
                vc.present(viewController!, animated: true) {
                    self.checkLocalAuthenticated()
                }
            }else {
                self.checkLocalAuthenticated()
            }
        }
    }
    
    func checkLocalAuthenticated() {
        if !GKLocalPlayer.local.isAuthenticated {
            print("没有授权，无法获取更多信息")
            GameUserInfoConfig.shared.gameId = ""
            GameUserInfoConfig.shared.gameName = "聚玩者"
            sebWithoutAuthorizationViews()
        }else{
            //存储玩家信息 - id - name
            let localPlayer = GKLocalPlayer.local
            GameUserInfoConfig.shared.gameId = localPlayer.gamePlayerID
            GameUserInfoConfig.shared.gameName = localPlayer.displayName
            
            sebViews()

        }
    }
}
