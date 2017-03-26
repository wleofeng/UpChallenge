//
//  Timer.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/26/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import Foundation

protocol VoiceTimerDelegate: class {
    func timeToSpeak(lyric: String)
}

class VoiceTimer: NSObject {
    var lyrics: [[Int: String]] = [
        [1: "Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground."],
        [5: "2 Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground."]
    ]
    
    var timer: Timer = Timer()
    var seconds: Int = 0
    var nextLyric: String = ""
    
    weak var delegate: VoiceTimerDelegate?
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
    }
    
    func stopTimer() {
        //        timer.stopTimer()
    }
    
    func resetTimer() {
        seconds = 0
    }
    
    func update() {
        seconds += 1
        
        if let lyric: [Int: String] = getNextLyric() {
            if let val = lyric[seconds] {
                // speak out val
                //                nextLyric = val
                delegate?.timeToSpeak(lyric: val)
                
                lyrics.removeFirst()
            }
        }
        
    }
    
    
    
    func getNextLyric() -> [Int: String]? {
        if lyrics.count > 0 {
            return lyrics[0]
        }
        
        return nil
    }
}
