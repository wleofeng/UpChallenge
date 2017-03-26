//
//  AttributedSpeechViewController.swift
//  iOS-10-Sampler
//
//  Created by Shuichi Tsutsumi on 9/3/16.
//  Copyright © 2016 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import AVFoundation

class AttributedSpeechViewController: UIViewController, VoiceTimerDelegate {
    
    @IBOutlet private weak var label: UILabel!
    
    private let speech = AVSpeechSynthesizer()
    //    private let baseStr = "iOS 10 Sampler is a collection of code examples for new APIs of iOS 10."
    //    private let baseStr = "Sally up"
    private let baseStr = "Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground. Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground. Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground. Bring Sally up and bring Sally down.Lift and squat, gotta tear the ground."
    //    private let baseStr = "Push Up, down, up, down, up, down"
    private var attributedStr: NSMutableAttributedString!
    private var utterance: AVSpeechUtterance!
    
    var voiceTimer = VoiceTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attributedStr = NSMutableAttributedString(string: baseStr)
        let rangeAll = NSMakeRange(0, baseStr.characters.count)
        let rangeBold = NSString(string: baseStr).range(of: "iOS")
        attributedStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], range: rangeAll)
        attributedStr.addAttributes([NSForegroundColorAttributeName: UIColor.black], range: rangeAll)
        attributedStr.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)], range: rangeBold)
        
        updateUtterance(attributed: false)
        
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
        
        voiceTimer.delegate = self
    }
    
    private func updateUtterance(attributed: Bool) {
        if attributed {
            utterance = AVSpeechUtterance(attributedString: attributedStr)
            label.attributedText = attributedStr
        } else {
            utterance = AVSpeechUtterance(string: baseStr)
            utterance.rate = 0.3  // Range 0.0 - 1.0, default is 0.5
            utterance.pitchMultiplier = 1.5 // [0.5 - 2] Default = 1
            label.text = baseStr
        }
    }
    
    func timeToSpeak(lyric: String) {
        print("speaking" + lyric)
        
        setUtterance(with: lyric)
        speech.speak(utterance)
    }
    
    func setUtterance(with text: String) {
        utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.3  // Range 0.0 - 1.0, default is 0.5
        utterance.pitchMultiplier = 1.5 // [0.5 - 2] Default = 1
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func speechBtnTapped(sender: UIButton) {
        if speech.isSpeaking {
            print("already speaking...")
            return
        }
//        speech.speak(utterance)
        
        voiceTimer.startTimer()
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        updateUtterance(attributed: sender.isOn)
    }
    
}
