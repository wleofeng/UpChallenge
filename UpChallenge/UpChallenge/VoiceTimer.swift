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
    
    var timer: Timer?
    var seconds: Int = 0
    var nextLyric: String = ""
    
    weak var delegate: VoiceTimerDelegate?
    
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(update),
                                         userInfo: nil,
                                         repeats: true);
        }
    }
    
    func resetTimer() {
        seconds = 0
        
        stopTimer()
    }
    
    func pauseTimer() {
        stopTimer()
    }
    
    
    // Internal Mehtods
    
    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc private func update() {
        seconds += 1
        
        print(seconds)
        
        if let lyric: [Int: String] = getNextLyric() {
            // No need to continue if the timer already went pass the lyric trigger time
            let secondsInLyric = Array(lyric.keys)[0]
            if secondsInLyric < seconds {
                lyrics.removeFirst()
                
                return
            }
            
            if let val = lyric[seconds] {
                delegate?.timeToSpeak(lyric: val)
                lyrics.removeFirst()
            }
        }
        
    }
    
    private func getNextLyric() -> [Int: String]? {
        if lyrics.count > 0 {
            return lyrics[0]
        }
        
        return nil
    }
    
    private func initializeLyrics() {
        
    }
}
