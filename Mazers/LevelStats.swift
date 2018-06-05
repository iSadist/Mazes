//
//  LevelStats.swift
//  Mazers
//
//  Created by Jan Svensson on 2018-06-05.
//  Copyright © 2018 Jan Svensson. All rights reserved.
//

import Foundation

class LevelStats {
    
    let level: Int
    var timesDied: Int
    var fastestTime: Float?
    
    init(level: Int) {
        self.level = level
        timesDied = 0
    }
    
    func setNewTime(time: Float) -> Bool {
        if let currentFastestTime = fastestTime {
            if time < currentFastestTime {
                fastestTime = time
                return true
            }
        } else {
            fastestTime = time
            return true
        }
        return false
    }
    
}
