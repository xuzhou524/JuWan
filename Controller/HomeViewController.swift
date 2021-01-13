//
//  HomeViewController.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit
import GameKit
import GameplayKit

class HomeViewController: UIViewController,GKGameCenterControllerDelegate {
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "color_theme")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()
        titleLabel.font = blodFontWithSize(25)
        titleLabel.textColor = UIColor(named: "color_title_black")
        titleLabel.text = "聚玩"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)

        authenticateLocalPlayer()

    }
    
    func sebViews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let view2048 = Home2048View()
        view2048.layer.cornerRadius = 10
        view2048.layer.masksToBounds = true
        view2048.tipButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        
        view2048.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 150)
        
        tableView.tableHeaderView = view2048
        
        regClass(tableView, cell: RankListTableViewCell.self)
    }
    
    @objc func startGameButtonTapped() {
        let v = Play2048ViewController(dimension: 4, threshold: 2048)
        self.navigationController?.pushViewController(v, animated: true)
    }

    @objc func globalButtonTapped() {
        let gameCenterVC = GKGameCenterViewController()
        gameCenterVC.gameCenterDelegate = self
        self.present(gameCenterVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
}

extension HomeViewController {
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) {
                let vc: UIViewController = self.view!.window!.rootViewController!
                vc.present(viewController!, animated: true) {
                    self.sebViews()
                }
            }else {
                self.sebViews()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: RankListTableViewCell.self, indexPath: indexPath)
        
        return cell
    }

}
