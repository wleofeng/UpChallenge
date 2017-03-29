//
//  AttributedSpeechViewController.swift
//  iOS-10-Sampler
//
//  Created by Shuichi Tsutsumi on 9/3/16.
//  Copyright © 2016 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    fileprivate let speech: AVSpeechSynthesizer = AVSpeechSynthesizer()
    fileprivate var utterance: AVSpeechUtterance = AVSpeechUtterance()
    fileprivate var voiceTimer: VoiceTimer!
}

// MARK: View cycle
extension SpeechViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Voice
        var voiceToUse: AVSpeechSynthesisVoice?
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                if voice.name == "Karen" {
                    voiceToUse = voice
                }
            }
        }
        
        utterance.voice = voiceToUse
        
//        var lyricParser = LyricParser(fileName: "lyrics")
        voiceTimer = VoiceTimer(fileName: "lyrics")
        voiceTimer.delegate = self
    }
}

// MARK: VoiceTimerDelegate
extension SpeechViewController: VoiceTimerDelegate {
    
    func timeToSpeak(voiceTimer: VoiceTimer) {
        print("speaking" + voiceTimer.lyric)
        
        label.text = voiceTimer.lyric
        setUtterance(with: voiceTimer.lyric)
        speech.speak(utterance)
    }
}

// MARK: Button handler
extension SpeechViewController {
    
    @IBAction func speechBtnTapped(sender: UIButton) {
        voiceTimer.startTimer()
        
        if speech.isSpeaking { // handle the speech pause case
            speech.continueSpeaking()
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        voiceTimer.pauseTimer()
        
        speech.pauseSpeaking(at: .immediate)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        voiceTimer.resetTimer()
        
        speech.stopSpeaking(at: .immediate)
    }
}


// MARK: Helper
extension SpeechViewController {
    
    func setUtterance(with text: String) {
        utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.3  // Range 0.0 - 1.0, default is 0.5
        utterance.pitchMultiplier = 1.5 // [0.5 - 2] Default = 1
    }
}
