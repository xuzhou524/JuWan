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
    
    var isNoFirst: Bool = true
    var scores:[GKScore]?
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "color_theme")
        return tableView
    }()
    
    let emptyView:EmptyCell = {
        let view = EmptyCell()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLocalAuthenticated()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "数和"
        self.view.backgroundColor = UIColor(named: "color_theme")

    }
    
    func sebViews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let viewShuHe = HomeCardView()
        viewShuHe.layer.cornerRadius = 10
        viewShuHe.layer.masksToBounds = true
        viewShuHe.tipButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        
        viewShuHe.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 230)
        
        tableView.tableHeaderView = viewShuHe
        
        regClass(tableView, cell: RankListTableViewCell.self)
        regClass(tableView, cell: EmptyCell.self)
    }
    
    func sebWithoutAuthorizationViews() {
        self.view.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
    }
    
    @objc func startGameButtonTapped() {
        let v = Play2048ViewController(dimension: GameDecorateConfig.shared.gameShuHeDialNum, threshold: 4194304)
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

extension HomeViewController {

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
            downLoadGameCenter()
        }
    }
    
    func downLoadGameCenter() {
        let leaderboadRequest = GKLeaderboard()
        //设置好友的范围
        leaderboadRequest.playerScope = .global
        
        let type = "all"
        if type == "today" {
            leaderboadRequest.timeScope = .today
        }else if type == "week" {
            leaderboadRequest.timeScope = .week
        }else if type == "all" {
            leaderboadRequest.timeScope = .allTime
        }
        
        //哪一个排行榜
        let identifier = "juWan_shuhe"
        leaderboadRequest.identifier = identifier
        //从那个排名到那个排名
        let location = 1
        let length = 100
        leaderboadRequest.range = NSRange(location: location, length: length)
        
        //请求数据
        leaderboadRequest.loadScores { (scores, error) in
            if (error != nil) {
                print("请求分数失败")
                print("error = \(error)")
            }else{
                print("请求分数成功")
                self.scores = scores
                self.tableView.reloadData()
                if let sss = scores as [GKScore]?  {
                    for score in sss {
                        let gamecenterID = score.leaderboardIdentifier
                        let playerName = score.player.displayName
                        let scroeNumb = score.value
                        let rank = score.rank
                        let gamePlayerID = score.player.gamePlayerID
                        if GameUserInfoConfig.shared.gameId == gamePlayerID && GameUserInfoConfig.shared.gameName == playerName {
                            GameUserInfoConfig.shared.gameShuHeHigheScore = Int(scroeNumb)
                        }
                        print("排行榜 = \(gamecenterID),玩家id = \(gamePlayerID),玩家名字 = \(playerName),玩家分数 = \(scroeNumb),玩家排名 = \(rank)")
                    }
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scores?.count ?? 0 > 0 ? 95 : 0
    }
     
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = RankHeadView()
        view.tipView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(globalButtonTapped)))
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: RankListTableViewCell.self, indexPath: indexPath)
        let score = scores?[indexPath.row]
        if indexPath.row == 0 {
            cell.rankLabel.isHidden = true
            cell.iconImageView.isHidden = false
            cell.iconImageView.image = UIImage(named: "one")
        }else if indexPath.row == 1 {
            cell.rankLabel.isHidden = true
            cell.iconImageView.isHidden = false
            cell.iconImageView.image = UIImage(named: "two")
        }else if indexPath.row == 2 {
            cell.rankLabel.isHidden = true
            cell.iconImageView.isHidden = false
            cell.iconImageView.image = UIImage(named: "three")
        }else{
            cell.rankLabel.isHidden = false
            cell.iconImageView.isHidden = true
            cell.rankLabel.text = "\(indexPath.row + 1)"
        }
        cell.titleLabel.text = score?.player.displayName
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        cell.scoreLabel.text = format.string(from: NSNumber(value: score?.value ?? 0))
        return cell

    }
}
