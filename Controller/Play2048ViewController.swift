//
//  Play2048ViewController.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit
import GameKit
import GameplayKit

class Play2048ViewController: UIViewController,GameModelProtocol {
    var model: GameModel?
    var board: GameboardView?
    
    let viewPadding: CGFloat = 10.0
    let verticalViewOffset: CGFloat = 0.0
    let thinPadding: CGFloat = 3.0
    let thickPadding: CGFloat = 6.0
    let boardWidth: CGFloat = kScreenWidth - 60
    
    var dimension: Int
    var threshold: Int
        
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(28)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "数和"
        return label
    }()
    
    let scoreLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(32)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "0"
        return label
    }()
    
    let highScoreLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(18)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "\(GameUserInfoConfig.shared.gameShuHeHigheScore)"
        return label
    }()
    
    let crownImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_crown")
        return imageView
    }()
    
    let rulesLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(15)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "color_title_black")
        label.text = "规则：上下左右滑动两个相同数字方块撞在一起之后合并成为他们的和，直到无法移动，所有和相加即为本局分数"
        return label
    }()
    
    let mobileAreaView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    init(dimension d: Int, threshold t: Int) {
        dimension = d > 2 ? d : 2
        threshold = t > 8 ? t : 8
        super.init(nibName: nil, bundle: nil)
        model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
        setupSwipeControls()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        navTipView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(highScoreLabel)
        highScoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(10)
        }
        
        self.view.addSubview(crownImageView)
        crownImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(highScoreLabel)
            make.right.equalTo(highScoreLabel.snp.left).offset(-5)
            make.width.height.equalTo(18)
        }

        self.view.addSubview(mobileAreaView)
        mobileAreaView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(kScreenWidth)
        }
        
        let padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
        let v1 = boardWidth - padding*(CGFloat(dimension + 1))
        let width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
        board = GameboardView(dimension: dimension,
                                      tileWidth: width,
                                      tilePadding: padding,
                                      cornerRadius: 6,
                                      backgroundColor: UIColor(named: "color_title_black")!,
                                      foregroundColor: UIColor(named: "color_themeBackground")!)

        var f = board?.frame
        f?.origin.x = 30
        f?.origin.y = 30
        board?.frame = f!
        
        mobileAreaView.addSubview(board!)
        assert(model != nil)
        let m = model!
        m.insertTileAtRandomLocation(value: 2)
        m.insertTileAtRandomLocation(value: 2)
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(mobileAreaView.snp.top).offset(-20)
            make.left.equalToSuperview().offset(30)
        }
        
        self.view.addSubview(rulesLabel)
        rulesLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(mobileAreaView.snp.bottom).offset(20)
        }
        
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension Play2048ViewController {
    func setupSwipeControls() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upCommand(r:)))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        mobileAreaView.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downCommand(r:)))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        mobileAreaView.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftCommand(r:)))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        mobileAreaView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightCommand(r:)))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        mobileAreaView.addGestureRecognizer(rightSwipe)
    }
    
    // Misc
    func followUp() {
        assert(model != nil)
        let m = model!
//        let (userWon, _) = m.userHasWon()
        
        //保存分数
        saveHighScore(s: m.score)
        if m.score > GameUserInfoConfig.shared.gameShuHeHigheScore {
            GameUserInfoConfig.shared.gameShuHeHigheScore = m.score
            highScoreLabel.text = "\(GameUserInfoConfig.shared.gameShuHeHigheScore)"
        }
//
//        if userWon {
//            let tip = LDTipAlertView.init(message: "你赢了！", buttonTitles: ["我知道了"])
//            tip?.show()
//            return
//        }
        let randomVal = Int(arc4random_uniform(10))
        m.insertTileAtRandomLocation(value: randomVal == 1 ? 4 : 2)
        if m.userHasLost() {
            let tip = LDTipAlertView.init(message: "你输了...", buttonTitles: ["我知道了"])
            tip?.show()
        }
    }
    
    // Commands
    @objc func upCommand(r: UIGestureRecognizer!) {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.Up,
                    completion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
                    })
    }
    
    @objc func downCommand(r: UIGestureRecognizer!) {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.Down,
                    completion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
                    })
    }
    
    @objc func leftCommand(r: UIGestureRecognizer!) {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.Left,
                    completion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
                    })
    }
    
    @objc func rightCommand(r: UIGestureRecognizer!) {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.Right,
                    completion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
                    })
    }
    
    // Protocol
    func scoreChanged(score: Int) {
        scoreLabel.text = "\(score)"
    }

    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
        assert(board != nil)
        let b = board!
        b.moveOneTile(from: from, to: to, value: value)
    }

    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        assert(board != nil)
        let b = board!
        b.moveTwoTiles(from: from, to: to, value: value)
    }

    func insertTile(location: (Int, Int), value: Int) {
        assert(board != nil)
        let b = board!
        b.insertTile(pos: location, value: value)
    }
}

extension Play2048ViewController {
    func saveHighScore(s:NSInteger){
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "juWan_shuhe")
            scoreReporter.value = Int64(s)
            GKScore.report([scoreReporter], withCompletionHandler: nil)
        }
    }
}
