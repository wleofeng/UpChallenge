//
//  Timer.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/26/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import Foundation

protocol VoiceTimerDelegate: class {
    
    func timeToSpeak(voiceTimer: VoiceTimer)
}

class VoiceTimer {

    fileprivate var lyrics: [Lyric] = []
    fileprivate var timer: Timer?
    fileprivate var seconds: Int = 0
    public fileprivate(set) var lyric: String = ""
    
    weak var delegate: VoiceTimerDelegate?
    
    
    init(fileName: String) {
        let parser = LyricParser(fileName: fileName)
        self.lyrics = parser.lyrics
    }
    
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
}

// MARK: Internal Methods
extension VoiceTimer {
    
    fileprivate func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc fileprivate func update() {
        seconds += 1
        
        print(seconds)
        
        if let lyric = getNextLyric() {
            // No need to continue if the timer already went pass the lyric trigger time
            let secondsInLyric = lyric.time
            if secondsInLyric < seconds {
                lyrics.removeFirst()
                
                return
            }
        
            self.lyric = lyric.lyric
            delegate?.timeToSpeak(voiceTimer: self)
            lyrics.removeFirst()
        }
        
    }
    
    fileprivate func getNextLyric() -> Lyric? {
        if lyrics.count > 0 {
            return lyrics[0]
        }
        
        return nil
    }
}
