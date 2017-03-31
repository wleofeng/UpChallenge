//
//  VoicesTableViewController.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/30/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import UIKit
import AVFoundation

protocol VoicesTableViewControllerDelegate: class {
    func didSelectVoice(voicesTableViewController: VoicesTableViewController)
}

class VoicesTableViewController: UITableViewController {
    
    var voices: [AVSpeechSynthesisVoice] = []
    var selectedVoice: AVSpeechSynthesisVoice?
    
    weak var delegate: VoicesTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.clearsSelectionOnViewWillAppear = false
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voices.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoicesTableViewCell", for: indexPath)

        let voice = voices[indexPath.row]
        cell.textLabel?.text = voice.name
        
        return cell
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVoice = voices[indexPath.row]
        
        self.delegate?.didSelectVoice(voicesTableViewController: self)
        
        self.navigationController?.popViewController(animated: true)
    }
}
