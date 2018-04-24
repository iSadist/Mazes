//
//  Player.swift
//  Mazers
//
//  Created by Jan Svensson on 2017-11-08.
//  Copyright © 2017 Jan Svensson. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Player: SKShapeNode {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touched!")
        
        touches.first?.location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Moved!")
        self.position = (touches.first?.location(in: self))!
    }
    
}
