//
//  Lyric.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/28/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import Foundation

class Lyric {
    /*
     utterance.rate = 0.3  // Range 0.0 - 1.0, default is 0.5
     utterance.pitchMultiplier = 1.5 // [0.5 - 2] Default = 1
     utterance.volume = 1 // [0-1] Default = 1
     */
    
    var time: Int = 0
    var lyric: String = ""
    var rate: Float = 0.5
    var pitchMultiplier: Float = 1.0
    var volume: Float = 1.0

    
    init() {}
    
    init(time: Int, lyric: String) {
        self.time = time
        self.lyric = lyric
    }
}
