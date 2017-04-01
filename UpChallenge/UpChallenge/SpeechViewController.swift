//
//  LyricParser.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/27/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechViewController: UIViewController {
    
    @IBOutlet weak var lyriclabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    fileprivate let speech: AVSpeechSynthesizer = AVSpeechSynthesizer()
    fileprivate var utterance: AVSpeechUtterance = AVSpeechUtterance()
    fileprivate var voiceTimer: VoiceTimer!
    fileprivate var voice: AVSpeechSynthesisVoice?
}

// MARK: View cycle
extension SpeechViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default text
        timerLabel.text = "00:00:00"
        lyriclabel.text = "Press speaker to begin!"
        
        var voiceToUse: AVSpeechSynthesisVoice?
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                if voice.name == "Daniel" {
                    voiceToUse = voice
                }
            }
        }
        voice = voiceToUse ?? AVSpeechSynthesisVoice.speechVoices().first
        
        // Voice Timer
        voiceTimer = VoiceTimer(fileName: Constant.FileName)
        voiceTimer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: VoiceTimerDelegate
extension SpeechViewController: VoiceTimerDelegate {
    
    func timeToSpeak(voiceTimer: VoiceTimer) {
        print("speaking" + voiceTimer.lyric)
        
        lyriclabel.text = voiceTimer.lyric
        setUtterance(with: voiceTimer.lyric)
        speech.speak(utterance)
    }
    
    func timerDidUpdate(voiceTimer: VoiceTimer) {
        
        timerLabel.text = formattedTime(seconds: voiceTimer.seconds)
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


// MARK: Helpers
extension SpeechViewController {
    
    func formattedTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        
        let result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return result
    }
    
    func setUtterance(with text: String) {
        utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        //        utterance.rate = 0.3  // Range 0.0 - 1.0, default is 0.5
        //        utterance.pitchMultiplier = 1.5 // [0.5 - 2] Default = 1
    }
}

// MARK: Segue handler
extension SpeechViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? VoicesTableViewController {
            viewController.voices = AVSpeechSynthesisVoice.speechVoices()
            viewController.delegate = self
        }
    }
}

// MARK: VoicesTableViewControllerDelegate
extension SpeechViewController: VoicesTableViewControllerDelegate {
    
    func didSelectVoice(voicesTableViewController: VoicesTableViewController) {
        voice = voicesTableViewController.selectedVoice
        
        speech.stopSpeaking(at: .immediate) // stop speaking in order to reset the voice
    }
}
