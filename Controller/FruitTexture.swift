//
//  FruitTexture.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import Foundation

func getFruitTextureByName(fruitName: String) -> FruitTexture {
    FruitTexture.allCases.first{ $0.imageName == fruitName }!
}

func getNumberTexture(_ number: Int) -> String {
    return "\(number)"
}

enum FruitTexture: String, CaseIterable {
    case grape = "grape"
    case cherry = "cherry"
    case orange = "orange"
    case lemon = "lemon"
    case kiwi = "kiwi"
    case tomato = "tomato"
    case peach = "peach"
    case pineapple = "pineapple"
    case cocount = "cocount"
    case halfwatermelon = "halfwatermelon"
    case watermelon = "watermelon"
    
    var imageName: String {
        rawValue
    }
    
    var bitMask: UInt32 {
        switch self {
        case .grape:
            return 0x1 << 1
        case .cherry:
            return 0x1 << 2
        case .orange:
            return 0x1 << 3
        case .lemon:
            return 0x1 << 4
        case .kiwi:
            return 0x1 << 5
        case .tomato:
            return 0x1 << 6
        case .peach:
            return 0x1 << 7
        case .pineapple:
            return 0x1 << 8
        case .cocount:
            return 0x1 << 9
        case .halfwatermelon:
            return 0x1 << 10
        case .watermelon:
            return 0x1 << 11
        }
    }
}
