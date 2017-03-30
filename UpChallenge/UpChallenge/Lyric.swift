//
//  Lyric.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/28/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import Foundation

class Lyric {
    var time: Int = 0
    var lyric: String = ""
    // more config possible per lyric line
    
    init(time: Int, lyric: String) {
        self.time = time
        self.lyric = lyric
        
    }
}
