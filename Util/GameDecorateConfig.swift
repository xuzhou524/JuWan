//
//  GameDecorateConfig.swift
//  JuWan
//
//  Created by fanzhe on 2021/1/18.
//

import UIKit

class GameDecorateConfig: NSObject {
    static let shared = GameDecorateConfig()
    
    /// Game配置
    //主题色
    var gameShuHeThemeType: Int = 1

    //表盘
    var gameShuHeDialNum: Int = 5
}
