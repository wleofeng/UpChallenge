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
    func timerDidUpdate(voiceTimer: VoiceTimer)
}

class VoiceTimer {

    public fileprivate(set) var lyric: String = ""
    public fileprivate(set) var seconds: Int
    
    fileprivate var lyrics: [Lyric]
    fileprivate var timer: Timer?

    weak var delegate: VoiceTimerDelegate?

    
    init(seconds: Int, lyrics: [Lyric]) {
        self.seconds = seconds
        self.lyrics = lyrics
    }
    
    convenience init() {
        self.init(seconds: 0, lyrics: [])
    }
    
    convenience init(fileName: String) {
        let parser = LyricParser(fileName: fileName)
        self.init(seconds: 0, lyrics: parser.lyrics)
    }
    
    convenience init(data: Data) {
        let parser = LyricParser(data: data)
        self.init(seconds: 0, lyrics: parser.lyrics)
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
        delegate?.timerDidUpdate(voiceTimer: self)
        
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
