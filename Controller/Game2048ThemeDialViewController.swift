//
//  Game2048ThemeDialViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/21.
//

import UIKit

class Game2048ThemeDialViewController: UIViewController {
    
    var collectionView : UICollectionView!

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

    }

}

extension Game2048ThemeDialViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    //UICollectionView代理方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CDViewCell.self), for: indexPath) as! CDViewCell
        cell.goodsImg.image = UIImage(named: "theme_2048_\(indexPath.row + 1)")
        cell.nameLabel.font = blodFontWithSize(30)
        cell.nameLabel.text = ["4 × 4","5 × 5","6 × 6","7 × 7","8 × 8"][indexPath.row]
        cell.priceLabel.isHidden = true
        if indexPath.row + 1 == GameDecorateConfig.shared.game2048ThemeType {
            cell.selectView.isHidden = false
        }else{
            cell.selectView.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        GameDecorateConfig.shared.game2048ThemeType = indexPath.row + 1
        self.collectionView.reloadData()
        
    }
    
}
