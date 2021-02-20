//
//  GameShuHeThemeSettingViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/18.
//

import UIKit
import GoogleMobileAds

class GameShuHeThemeSettingViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    var interstitial: GADInterstitial!
    var bannerView: GADBannerView!
    
    var rewarded: GADRewardedAd!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        #else
        rewarded = createAndLoad()
        #endif
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择主题"
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        let layout = CDFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: (kScreenWidth - 40) / 5 + 20, bottom: 0, right: (kScreenWidth - 40) / 5 + 20)
        layout.itemSize = CGSize(width: (kScreenWidth - 40) * 3 / 5, height: (kScreenWidth - 40) * 3 / 5 + 100)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 50, width: kScreenWidth, height: (kScreenWidth - 40) * 3 / 5 + 100), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CDViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CDViewCell.self))
        collectionView.reloadData()
        self.view.addSubview(self.collectionView)
        
        #if DEBUG
        #else
        bannerView = GADBannerView.init(frame: CGRect(x: 0,  y: kScreenHeight - 180, width: kScreenWidth, height: 50))
        if (kIsFullScreen) {
            bannerView.frame = CGRect(x: 0,  y: kScreenHeight - 230, width: kScreenWidth, height: 50)
        }
        bannerView.adSize = kGADAdSizeBanner
        bannerView.center.x = self.view.center.x
        self.view.addSubview(bannerView)
        self.view.bringSubviewToFront(bannerView)
        bannerView.adUnitID = "ca-app-pub-9353975206269682/2479518012"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        #endif

    }
    
    func createAndLoad() -> GADRewardedAd {
        let rewarded = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        rewarded.load(GADRequest(), completionHandler: nil)
        return rewarded
    }
    
}

extension GameShuHeThemeSettingViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    //UICollectionView代理方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CDViewCell.self), for: indexPath) as! CDViewCell
        cell.goodsImg.image = UIImage(named: "theme_shuhe_\(indexPath.row + 1)")
        cell.nameLabel.text = ["天空蓝","玫瑰粉","经典"][indexPath.row]
        cell.priceLabel.text = ["无门槛","最高分 1,536 以上","最高分达 3,072 以上"][indexPath.row]
        if indexPath.row + 1 == GameDecorateConfig.shared.gameShuHeThemeType {
            cell.selectView.isHidden = false
        }else{
            cell.selectView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.row == 1 && GameUserInfoConfig.shared.gameShuHeHigheScore < 1536) ||
            (indexPath.row == 2 && GameUserInfoConfig.shared.gameShuHeHigheScore < 3072) {
            let tip = LDTipAlertView.init(message: "您的最高分暂未达到当前门槛，快去努力吧!", buttonTitles: ["我知道了"])
            tip?.show()
        }else{
            GameDecorateConfig.shared.gameShuHeThemeType = indexPath.row + 1
            self.collectionView.reloadData()
            
            #if DEBUG
            #else
            rewarded.present(fromRootViewController: self, delegate:self)
            #endif
        }
    }
    
}

extension GameShuHeThemeSettingViewController : GADInterstitialDelegate,GADRewardedAdDelegate{
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        self.dismiss(animated: true, completion: nil)
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
      rewarded = createAndLoad()
      print("Rewarded ad dismissed.")
    }
    
}
