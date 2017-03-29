//
//  LyricParser.swift
//  UpChallenge
//
//  Created by Wo Jun Feng on 3/27/17.
//  Copyright © 2017 wojunfeng. All rights reserved.
//

import Foundation
import SwiftyJSON

class LyricParser {
    
    var fileName: String?
    
    var songName: String = ""
    var lyrics: [Lyric] = []
    
    
    init(fileName: String) {
        self.fileName = fileName
        
        if let json = readFile(name: fileName) {
            commonInit(json: json)
        }
    }
    
    init(data: Data) {
        let json = JSON(data: data)
        if json != JSON.null {
            commonInit(json: json)
        }
    }
    
    fileprivate func commonInit(json: JSON) {
        if let name = json["name"].string {
            self.songName = name
        }
        
        let lyrics: [JSON] = json["lyrics"].arrayValue
        for lyric in lyrics {
            if let time = lyric["time"].int, let lyric = lyric["lyric"].string {
                self.lyrics.append(Lyric(time: time, lyric: lyric))
            }
        }
    }
    
    fileprivate func readFile(name: String) -> JSON? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    return jsonObj
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return nil
    }
    
}
