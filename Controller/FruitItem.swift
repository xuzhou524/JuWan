//
//  FruitItem.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import Foundation
import SpriteKit

class WatermelonElements {
    var randomCnt = 0
    private var groupMixArray:[String] = [
        FruitItem.pineapple.imageName,
        FruitItem.orange.imageName,
        FruitItem.lemon.imageName,
        FruitItem.kiwi.imageName,
        FruitItem.tomato.imageName,
        FruitItem.cocount.imageName,
        FruitItem.grape.imageName,
        FruitItem.cherry.imageName,
        FruitItem.peach.imageName,
        FruitItem.halfwatermelon.imageName,
        FruitItem.watermelon.imageName
    ]
    
    private func generateFruitByName(imageName: String) -> SKSpriteNode {
        let fruit = SKSpriteNode(imageNamed: imageName)
        fruit.name = imageName
        fruit.setScale(0.4)
        return fruit
    }
    
    let randomArray = [
        FruitItem.grape.imageName,
        FruitItem.cherry.imageName,
        FruitItem.orange.imageName,
        FruitItem.lemon.imageName,
        FruitItem.kiwi.imageName
    ]
    
    func randomFruit() -> SKSpriteNode {
        randomCnt += 1
        switch randomCnt {
        case 1...3:
            return generateFruitByName(imageName: FruitItem.grape.imageName)
        case 4:
            return generateFruitByName(imageName: FruitItem.cherry.imageName)
        case 5:
            return generateFruitByName(imageName: FruitItem.orange.imageName)
        default:
            return generateFruitByName(imageName: randomArray.randomElement()!)
        }
    }
    
    func getMixScore(before fruitname: String) -> Int{
        if fruitname == FruitItem.watermelon.imageName {
            return 0
        } else {
            return groupMixArray.firstIndex(of: fruitname)! + 1
        }
    }
    
    func mixFruit(before fruitname: String) -> String? {
        if fruitname == FruitItem.watermelon.imageName {
            return nil
        } else {
            return groupMixArray[(groupMixArray.firstIndex(of: fruitname)! + 1)]
        }
    }
}

func getFruitItemByName(fruitName: String) -> FruitItem {
    FruitItem.allCases.first{ $0.imageName == fruitName }!
}

func getNumberTexture(_ number: Int) -> String {
    return "\(number)"
}

enum FruitItem: String, CaseIterable {
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
