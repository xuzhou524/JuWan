//
//  UserViewController.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/15.
//

import UIKit
import StoreKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView = {
        let tableView = UITableView();
        tableView.backgroundColor = UIColor(named: "color_theme")
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: LeftTitleTableViewCell.self)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "我的"
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0
//        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(named: "color_theme")
        return bgView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = ["选择主题色","选择表盘"][indexPath.row]
            let names = ["ic_setting","ic_setting"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.isHiddenRightImage(hidden: false)
            cell.summeryLabel.isHidden = true
            return cell
        }else{
            let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = ["给个赞","隐私协议","版本号"][indexPath.row]
            let names = ["ic_givePraise","ic_settings_input_svideo","ic_settings_input_svideo"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            if indexPath.row == 2 {
                cell.isHiddenRightImage(hidden: true)
                let infoDict = Bundle.main.infoDictionary
                if let info = infoDict {
                   // app版本
                   let appVersion = info["CFBundleShortVersionString"] as! String?
                   cell.summeryLabel.text = "v" + appVersion!
                   cell.summeryLabel.isHidden = false
                }
            }else{
                cell.isHiddenRightImage(hidden: false)
                cell.summeryLabel.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.navigationController?.pushViewController(Game2048ThemeSettingViewController(), animated: true)
            }
        }else{
            if indexPath.row == 0 {
                #if DEBUG
                #else
                    SKStoreReviewController.requestReview()
                #endif
            }
        }
    }
    
}
