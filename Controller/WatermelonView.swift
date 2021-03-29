//
//  WatermelonView.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import SwiftUI
import SpriteKit

let screen = UIScreen.main.bounds

struct WatermelonView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: screen.width, height: screen.height)
        scene.scaleMode = .fill
        return scene
    }

    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: screen.width, height: screen.height)
                .ignoresSafeArea()
        }
            
    }
}

struct WatermelonView_Previews: PreviewProvider {
    static var previews: some View {
        WatermelonView()
    }
}