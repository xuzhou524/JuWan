//
//  AppearanceProvider.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

protocol AppearanceProviderProtocol: class {
    func tileColor(value: Int) -> UIColor
    func numberColor(value: Int) -> UIColor
    func fontForNumbers() -> UIFont
}

class AppearanceProvider: AppearanceProviderProtocol {
    
    // Provide a tile color for a given value
    func tileColor(value: Int) -> UIColor {
        switch GameDecorateConfig.shared.gameShuHeThemeType {
        case 1:
            switch value {
            case 3:
                return UIColor(hexString: "caf0f8")!
            case 6:
                return UIColor(hexString: "ade8f4")!
            case 12:
                return UIColor(hexString: "90e0ef")!
            case 24:
                return UIColor(hexString: "48cae4")!
            case 48:
                return UIColor(hexString: "00b4d8")!
            case 96:
                return UIColor(hexString: "0096c7")!
            case 192:
                return UIColor(hexString: "0077b6")!
            case 384:
                return UIColor(hexString: "023e8a")!
            case 768,1536, 3072, 6144,12288:
                return UIColor(hexString: "03045e")!
            default:
                return UIColor.white
            }
        case 2:
            switch value {
            case 3:
                return UIColor(hexString: "ffe0e9")!
            case 6:
                return UIColor(hexString: "ffc2d4")!
            case 12:
                return UIColor(hexString: "ff9ebb")!
            case 24:
                return UIColor(hexString: "ff7aa2")!
            case 48:
                return UIColor(hexString: "e05780")!
            case 96:
                return UIColor(hexString: "b9375e")!
            case 192:
                return UIColor(hexString: "8a2846")!
            case 384:
                return UIColor(hexString: "602437")!
            case 768,1536, 3072, 6144,12288:
                return UIColor(hexString: "522e38")!
            default:
                return UIColor.white
            }
        case 3:
            switch value {
            case 3:
                return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            case 6:
                return UIColor(red: 237.0/255.0, green: 224.0/255.0, blue: 200.0/255.0, alpha: 1.0)
            case 12:
                return UIColor(red: 242.0/255.0, green: 177.0/255.0, blue: 121.0/255.0, alpha: 1.0)
            case 24:
                return UIColor(red: 245.0/255.0, green: 149.0/255.0, blue: 99.0/255.0, alpha: 1.0)
            case 48:
                return UIColor(red: 246.0/255.0, green: 124.0/255.0, blue: 95.0/255.0, alpha: 1.0)
            case 96:
                return UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0)
            case 192:
                return UIColor(red: 247.0/255.0, green: 80.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            case 384:
                return UIColor(red: 247.0/255.0, green: 75.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            case 768,1536, 3072, 6144,12288:
                return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            default:
                return UIColor.white
            }
        default:
            return UIColor.white
        }
    }
    
    // Provide a numeral color for a given value
    func numberColor(value: Int) -> UIColor {
        switch value {
        case 1,2, 4:
            return UIColor(red: 119.0/255.0, green: 110.0/255.0, blue: 101.0/255.0, alpha: 1.0)
        default:
            return UIColor.white
        }
    }
    
    // Provide the font to be used on the number tiles
    func fontForNumbers() -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-Bold", size: 25) {
            return font
        }
        return UIFont.systemFont(ofSize: 20)
    }
}
