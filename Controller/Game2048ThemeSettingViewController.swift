//
//  Game2048ThemeSettingViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/18.
//

import UIKit

class Game2048ThemeSettingViewController: UIViewController {
    
    var collectionView : UICollectionView!

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

    }

}

extension Game2048ThemeSettingViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    //UICollectionView代理方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CDViewCell.self), for: indexPath) as! CDViewCell
        cell.goodsImg.image = UIImage(named: "theme_2048_\(indexPath.row + 1)")
        cell.nameLabel.text = ["经典","玫瑰粉","天空蓝"][indexPath.row]
        cell.priceLabel.text = ["无门槛","最高分 1,024 以上","最高分达 2,048 以上"][indexPath.row]
        if indexPath.row + 1 == GameDecorateConfig.shared.game2048ThemeType {
            cell.selectView.isHidden = false
        }else{
            cell.selectView.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 1 && GameUserInfoConfig.shared.game2048HigheScore < 1024) ||
            (indexPath.row == 2 && GameUserInfoConfig.shared.game2048HigheScore < 2048) {
            let tip = LDTipAlertView.init(message: "您的最高分暂未达到当前门槛，快去努力吧!", buttonTitles: ["我知道了"])
            tip?.show()
            return
        }
        GameDecorateConfig.shared.game2048ThemeType = indexPath.row + 1
        self.collectionView.reloadData()
        
    }
    
}

