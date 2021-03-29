//
//  Client.swift
//  JuWan
//
//  Created by gozap on 2021/3/29.
//

import UIKit

/// 将代码安全的运行在主线程
func dispatch_sync_safely_main_queue(_ block: ()->()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.sync {
            block()
        }
    }
}

func fontWithSize(_ size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}
func blodFontWithSize(_ size:CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: size)
}
func lightFontWithSize(_ size:CGFloat) -> UIFont{
    UIFont.systemFont(ofSize: size, weight: .thin)
    return UIFont(name: "Helvetica-Light", size: size)!
}
func weightFontWithSize(_ size:CGFloat, weight:UIFont.Weight) -> UIFont{
    return UIFont.systemFont(ofSize: size, weight: weight)
}

let kHalfPixel = 1 / UIScreen.main.scale

//屏幕宽高
let kScreenWidth  = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kIsFullScreen = (UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 ? true : false)

class FZImageView: UIImageView {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestSlop == UIEdgeInsets.zero {
            return super.point(inside: point, with:event)
        }
        else{
            return self.bounds.inset(by: hitTestSlop).contains(point)
        }
    }
}

class Client: NSObject {

}
