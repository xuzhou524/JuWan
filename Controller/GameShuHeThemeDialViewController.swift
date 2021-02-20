//
//  GameShuHeThemeDialViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/21.
//

import UIKit
import SwiftyStoreKit
import GoogleMobileAds

class GameShuHeThemeDialViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var isHaveBuy = false
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择表盘"
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
        
        restorePurchases()
        
//        getList()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
    
}

extension GameShuHeThemeDialViewController{
    
    func buyProduct() {
        SwiftyStoreKit.purchaseProduct("juwan_2048_Dial_6", quantity: 1, atomically: true) { result in
            MBProgressHUD.hideAllIndicator()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                GameDecorateConfig.shared.gameShuHeDialNum = 6
                self.collectionView.reloadData()
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default:
                    break
                }
            }
        }
    }
    
    //验证
//    func product() {
//        let receipt = AppleReceiptValidator(service: .production)
//        SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
//            switch result {
//            case .success(let receipt):
//             print("receipt--->\(receipt)")
//                self.isHaveBuy = true
//                self.collectionView.reloadData()
//                break
//            case .error(let error):
//                print("error--->\(error)")
//                break
//            }
//        }
//    }
    
    func restorePurchases() {
        SwiftyStoreKit.restorePurchases { (result) in
            if let sss = result.restoredPurchases as [Purchase]?  {
                for score in sss {
                    if score.productId == "juwan_2048_Dial_6" {
                        self.isHaveBuy = true
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}

extension GameShuHeThemeDialViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    //UICollectionView代理方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CDViewCell.self), for: indexPath) as! CDViewCell
        cell.nameLabel.text = ["4 × 4","5 × 5","6 × 6"][indexPath.row]
        cell.priceLabel.text = ["无门槛","无门槛",isHaveBuy ? "已购买" : "CNY 1.00"][indexPath.row]
        if indexPath.row == 0 {
            cell.goodsImg.image = UIImage(named: "theme_2048_1")
            cell.selectView.isHidden = GameDecorateConfig.shared.gameShuHeDialNum != 4
        }else if indexPath.row == 1{
            cell.goodsImg.image = UIImage(named: "theme_2048D_5")
            cell.selectView.isHidden = GameDecorateConfig.shared.gameShuHeDialNum != 5
        }else if indexPath.row == 2{
            cell.goodsImg.image = UIImage(named: "theme_2048D_6")
            cell.selectView.isHidden = GameDecorateConfig.shared.gameShuHeDialNum != 6
        }else{
            cell.selectView.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            GameDecorateConfig.shared.gameShuHeDialNum =  4
            collectionView.reloadData()
        }else if indexPath.row == 1 {
            GameDecorateConfig.shared.gameShuHeDialNum =  5
            collectionView.reloadData()
        }else if indexPath.row == 2 {
            if isHaveBuy {
                GameDecorateConfig.shared.gameShuHeDialNum = 6
                collectionView.reloadData()
            }else{
                //再次验证
                MBProgressHUD.showDefaultIndicator(withText: nil)
                let receipt = AppleReceiptValidator(service: .production)
                SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
                    switch result {
                    case .success(let receipt):
                        MBProgressHUD.hideAllIndicator()
                        print("receipt--->\(receipt)")
                        GameDecorateConfig.shared.gameShuHeDialNum = 6
                        self.collectionView.reloadData()
                        break
                    case .error(let error):
                        print("error--->\(error)")
                        self.buyProduct()
                        break
                    }
                }
            }
        }
    }
    
}
