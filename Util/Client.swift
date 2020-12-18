//
//  Client.swift
//  FanZhe
//
//  Created by gozap on 2020/10/17.
//

import UIKit

enum BPYSettingKey:String {
    /// 存放accessToken
    case accessToken = "account.accessToken"
    /// 存放phone
    case phone = "account.phone"
    
}

let Settings = BPYSettings.shared

class BPYSettings{
    static let shared = BPYSettings()
    private init(){
        
    }
    
    subscript(key:String) -> String? {
        get {
            let storeKey = Key<String>(key)
            return Defaults.shared.get(for: storeKey)
        }
        set {
            let storeKey = Key<String>(key)
            if let value = newValue {
                Defaults.shared.set(value, for: storeKey)
            }
            else {
                Defaults.shared.clear(storeKey)
            }
        }
    }
    
    subscript(key:BPYSettingKey) -> String? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
    
    subscript<T : Codable>(key:String) -> T? {
        get {
            let storeKey = Key<T>(key)
            return Defaults.shared.get(for: storeKey)
        }
        set {
            let storeKey = Key<T>(key)
            if let value = newValue {
                Defaults.shared.set(value, for: storeKey)
            }
            else {
                Defaults.shared.clear(storeKey)
            }
        }
    }
    subscript<T : Codable>(key:BPYSettingKey) -> T? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
}


class Client: NSObject {

    static let shared = Client()
    private override init() {
        super.init()
    }
    
    var mainWindow:UIWindow {
        get {
            let array = UIApplication.shared.connectedScenes
            let windowScene = array.first
            return (windowScene?.delegate as! SceneDelegate).window!
        }
    }
    
    var rootTabBarC:UITabBarController {
        get {
            let array = UIApplication.shared.connectedScenes
            let windowScene = array.first
            if let window = (windowScene?.delegate as! SceneDelegate).window {
                return window.rootViewController as! UITabBarController
            }else{
                return UITabBarController()
            }
        }
    }
    
    var currentNavigationController:XZNavigationController {
        get {
            let index = rootTabBarC.selectedIndex
            return rootTabBarC.viewControllers?[index] as! XZNavigationController
        }
    }
    
    public func isiPhoneXMore() -> Bool {
        return mainWindow.safeAreaInsets.bottom > CGFloat(0.00)
    }
    
    //获取字符串的高度
    func getTextHeigh(textStr:String, font : UIFont, width : CGFloat)  -> CGFloat{
        let normalText:NSString = textStr as NSString
        let size = CGSize(width: width, height:1000)
        let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
        return stringSize.height
    }
}
