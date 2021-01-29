//
//  AudioUtil.swift
//  Mix Watermelon
//
//  Created by Steve Yu on 2021/1/27.
//

import Foundation
import AVFoundation

class AudioUtil {
    var resourceName: String
    var playing = false
    var player: AVAudioPlayer!
    
    init(resourceName: String) {
        self.resourceName = resourceName
    }
    
    func playAudio() {
        if playing {
            return
        }
        do {
            guard let fileUrl = Bundle.main.url(forResource: resourceName, withExtension: "mp3", subdirectory: nil, localization: nil) else {
                print("Play Audio Error! file url can not be found")
                return
            }
            player = try AVAudioPlayer(contentsOf: fileUrl)
            player?.prepareToPlay()
            player?.play()
            playing = true
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.playing = false
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
}
