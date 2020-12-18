//
//  Defines.swift
//  FanZhe
//
//  Created by gozap on 2020/10/17.
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

//let kNavigationBarHeight:CGFloat = 44 + kSafeAreaInsets.top

//let kSafeAreaInsets:UIEdgeInsets = {
//    if #available(iOS 12.0, *){
//        return UIWindow().safeAreaInsets
//    }
//    if Device.current.isOneOf([.iPhoneX, .simulator(.iPhoneX)]) {
//        return UIEdgeInsets(top: 34, left: 0, bottom: 34, right: 0)
//    }
//    return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
//}()

extension Int {
    var money:String {
        get {
            if self >= 10000000 {
                return String(format: "%.2f", Double(self) / 100.0)
            }
            return String(format: "%g", Double(self) / 100.0)
        }
    }
}

extension UIView {
    func ts_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func addRoundedCorners(corners:UIRectCorner,radii:CGSize,rect:CGRect) {
        let rounded = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
}

extension String {
    
    //1, 截取规定下标之后的字符串
    func subStringFrom(index: Int)-> String {
        let temporaryString: String = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryIndex...])
    }
    
    //2, 截取规定下标之前的字符串
    func subStringTo(index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
    }
    
    func nsrange(fromRange range : Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }

}

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
 
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPhone11,8":   return "iPhone XR"
        case "iPhone11,2":   return "iPhone XS"
        case "iPhone11,6","iPhone11,4":   return "iPhone XS Max"
        case "iPhone12,1":   return "iPhone 11"
        case "iPhone12,3":   return "iPhone 11 Pro"
        case "iPhone12,5":   return "iPhone 11 Pro Max"
        case "iPhone12,8":   return "iPhone SE2"
        case "iPhone13,1":   return "iPhone 12 mini"
        case "iPhone13,2":   return "iPhone 12"
        case "iPhone13,3":   return "iPhone 12 Pro"
        case "iPhone13,4":   return "iPhone 12 Pro Max"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }
}
