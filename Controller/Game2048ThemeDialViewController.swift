//
//  Game2048ThemeDialViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/21.
//

import UIKit
import SwiftyStoreKit

class Game2048ThemeDialViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var isHaveBuy = false
    
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

        product()
        
//        getList()
    }
    
}

extension Game2048ThemeDialViewController{
//    //获取商品信息
//    func getList() {
//        SwiftyStoreKit.retrieveProductsInfo(["juwan_2048_Dial_6"]) { result in
//            if let product = result.retrievedProducts.first {
//                let priceString = product.localizedPrice!
//                print("Product: \(product.localizedDescription), price: \(priceString)")
//            } else if let invalidProductId = result.invalidProductIDs.first {
//                print("Invalid product identifier: \(invalidProductId)")
//            } else {
//                print("Error: \(result.error)")
//            }
//        }
//    }
    
    func buyProduct() {
        SwiftyStoreKit.purchaseProduct("juwan_2048_Dial_6", quantity: 1, atomically: true) { result in
            MBProgressHUD.hideAllIndicator()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                GameDecorateConfig.shared.game2048DialNum = 6
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
    func product() {
        let receipt = AppleReceiptValidator(service: .production)
        SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
            switch result {
            case .success(let receipt):
             print("receipt--->\(receipt)")
                self.isHaveBuy = true
                self.collectionView.reloadData()
                break
            case .error(let error):
             print("error--->\(error)")
                break
            }
        }
    }
}

extension Game2048ThemeDialViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    //UICollectionView代理方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CDViewCell.self), for: indexPath) as! CDViewCell
        cell.nameLabel.text = ["4 × 4","6 × 6"][indexPath.row]
        cell.priceLabel.text = ["无门槛",isHaveBuy ? "已购买" : "CNY 1.00"][indexPath.row]
        if indexPath.row == 0 {
            cell.goodsImg.image = UIImage(named: "theme_2048_1")
            cell.selectView.isHidden = GameDecorateConfig.shared.game2048DialNum != 4
        }else if indexPath.row == 1{
            cell.goodsImg.image = UIImage(named: "theme_2048D_6")
            cell.selectView.isHidden = GameDecorateConfig.shared.game2048DialNum != 6
        }else{
            cell.selectView.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if isHaveBuy {
                GameDecorateConfig.shared.game2048DialNum = 6
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
                        GameDecorateConfig.shared.game2048DialNum = 6
                        self.collectionView.reloadData()
                        break
                    case .error(let error):
                        print("error--->\(error)")
                        self.buyProduct()
                        break
                    }
                }
            }
            
        }else{
            GameDecorateConfig.shared.game2048DialNum =  4
            collectionView.reloadData()
        }
        
    }
    
}
