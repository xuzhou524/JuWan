//
//  GameUserInfoConfig.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/25.
//

import UIKit

class GameUserInfoConfig: NSObject {
    static let shared = GameUserInfoConfig()

    //玩家昵称
    
    var gameId : String = ""
    var gameName: String = "聚玩者"
    
    //数和 最高分
    var gameShuHeHigheScore: Int = 0
    
    //我要吃瓜 最高分
    var gameWatermelonHigheScore: Int = 0

}
