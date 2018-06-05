//
//  Game.swift
//  Mazers
//
//  Created by Jan Svensson on 2018-06-05.
//  Copyright © 2018 Jan Svensson. All rights reserved.
//

import Foundation

class Game {
    
    static let manager = Game() // Make the class a singleton
    
    lazy var completedLevels = Array<LevelStats>()
    var tiltSensitivity: Int = 1
    var obsticleSpeed: Int = 3
    
    func addLevel(level: LevelStats) {
        print("Added level")
        completedLevels.append(level)
    }
    
    func getLevel(levelNumber: Int) -> LevelStats? {
        let desiredLevel = completedLevels.filter({ (level)  -> Bool in
            return level.level == levelNumber
        })
        
        return desiredLevel.first
    }
}
