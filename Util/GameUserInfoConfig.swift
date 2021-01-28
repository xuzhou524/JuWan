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
    
    //2048 最高分
    var game2048HigheScore: Int = 0

}
