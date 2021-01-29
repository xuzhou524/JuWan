//
//  FruitSlot.swift
//  Mix Watermelon
//
//  Created by Steve Yu on 2021/1/26.
//

import Foundation
import SpriteKit

class FruitSlot {
    var randomCnt = 0
    private var groupMixArray:[String] = [
        FruitTexture.grape.imageName,
        FruitTexture.cherry.imageName,
        FruitTexture.orange.imageName,
        FruitTexture.lemon.imageName,
        FruitTexture.kiwi.imageName,
        FruitTexture.tomato.imageName,
        FruitTexture.peach.imageName,
        FruitTexture.pineapple.imageName,
        FruitTexture.cocount.imageName,
        FruitTexture.halfwatermelon.imageName,
        FruitTexture.watermelon.imageName
    ]
    
    private func generateFruitByName(imageName: String) -> SKSpriteNode {
        let fruit = SKSpriteNode(imageNamed: imageName)
        fruit.name = imageName
        fruit.setScale(0.4)
        return fruit
    }
    
    let randomArray = [
        FruitTexture.grape.imageName,
        FruitTexture.cherry.imageName,
        FruitTexture.orange.imageName,
        FruitTexture.lemon.imageName,
        FruitTexture.kiwi.imageName
    ]
    
    func randomFruit() -> SKSpriteNode {
        randomCnt += 1
//        return generateFruitByName(imageName: FruitTexture.halfwatermelon.imageName)
        switch randomCnt {
        case 1...3:
            return generateFruitByName(imageName: FruitTexture.grape.imageName)
        case 4:
            return generateFruitByName(imageName: FruitTexture.cherry.imageName)
        case 5:
            return generateFruitByName(imageName: FruitTexture.orange.imageName)
        default:
            return generateFruitByName(imageName: randomArray.randomElement()!)
        }
    }
    
    func getMixScore(before fruitname: String) -> Int{
        if fruitname == FruitTexture.watermelon.imageName {
            return 0
        } else {
            return groupMixArray.firstIndex(of: fruitname)! + 1
        }
    }
    
    func mixFruit(before fruitname: String) -> String? {
        if fruitname == FruitTexture.watermelon.imageName {
            return nil
        } else {
            return groupMixArray[(groupMixArray.firstIndex(of: fruitname)! + 1)]
        }
    }
}
