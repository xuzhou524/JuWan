//
//  ContentView.swift
//  Mix Watermelon
//
//  Created by Steve Yu on 2021/1/26.
//

import SwiftUI
import SpriteKit

let screen = UIScreen.main.bounds

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
