//
//  UIViewController+Extension.swift
//  FanZhe
//
//  Created by gozap on 2020/10/17.
//

import UIKit
import SnapKit

extension UIViewController:UINavigationControllerDelegate {

    func showloading(){
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_themeBackground")
        view.tag = 987001
        self.view.addSubview(view)
        self.view.bringSubviewToFront(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let spinner = UIActivityIndicatorView (style: .medium)
        spinner.startAnimating()
        spinner.tag = 987002
        spinner.frame = CGRect(x: kScreenWidth / 2.0 - 10, y: kScreenHeight / 2.0 - 100, width: 20, height: 20)
        spinner.color = UIColor(named: "color_title_black")
        self.view.addSubview(spinner)
    }
    func hideLoading() {
        let view = self.view.viewWithTag(987001)
        let spinner = self.view.viewWithTag(987002)
        
        view?.alpha = 0
        view?.isHidden = true
        spinner?.isHidden = false
        
        spinner?.removeFromSuperview()
        view?.removeFromSuperview()
        
        
//        UIView.animate(withDuration: 0.3, animations: {
//            view?.alpha = 0
//            view?.isHidden = true
//            spinner?.isHidden = false
//        }) { (_) in
//            spinner?.removeFromSuperview()
//            view?.removeFromSuperview()
//        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.setNavigationBarHidden(true, animated: true)
        }else{
            if navigationController.isKind(of: UIImagePickerController.classForCoder()) {
                return
            }
            navigationController.setNavigationBarHidden(false, animated: true)
        }
    }
}