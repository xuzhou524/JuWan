//
//  Play2048ViewController.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

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
    
    var scoreView: ScoreViewProtocol?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(35)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "2048"
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
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalTo(navTipView.snp.bottom).offset(20)
        }
        
        self.view.addSubview(mobileAreaView)
        mobileAreaView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.height.equalTo(kScreenWidth)

        }
        
        let padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
        let v1 = boardWidth - padding*(CGFloat(dimension + 1))
        let width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
        board = GameboardView(dimension: dimension,
                                      tileWidth: width,
                                      tilePadding: padding,
                                      cornerRadius: 6,
                                      backgroundColor: UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0),
                                      foregroundColor: UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0))

        var f = board?.frame
        f?.origin.x = 30
        f?.origin.y = 30
        board?.frame = f!
        
        mobileAreaView.addSubview(board!)
        assert(model != nil)
        let m = model!
        m.insertTileAtRandomLocation(value: 2)
        m.insertTileAtRandomLocation(value: 2)
        
        setupGame()
    }
    
    @objc func backClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func setupGame() {
        let scoreView = ScoreView(backgroundColor:UIColor(red: 237.0/255.0, green: 224.0/255.0, blue: 200.0/255.0, alpha: 1.0),
                                  textColor: UIColor.white,
                                  font: UIFont(name: "HelveticaNeue-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0),
                                  radius: 6)
        scoreView.score = 0
        view.addSubview(scoreView)
        self.scoreView = scoreView

        scoreView.frame = CGRect(x: kScreenWidth - 100 - 20, y: 100, width: 100, height: 80)

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
        let (userWon, _) = m.userHasWon()
        if userWon {
            let tip = LDTipAlertView.init(message: "你赢了！", buttonTitles: ["我知道了"])
            tip?.show()
            return
        }
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
        if scoreView == nil {
            return
        }
        let s = scoreView!
        s.scoreChanged(newScore: score)
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
