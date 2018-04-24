//
//  MovingObsticle.swift
//  Mazers
//
//  Created by Jan Svensson on 2017-11-08.
//  Copyright © 2017 Jan Svensson. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MovingObsticle: SKSpriteNode {
    
    private var direction: CGVector? = CGVector.init(dx: 0, dy: 1)
    
    override func intersects(_ node: SKNode) -> Bool {
        if node.intersects(self) {
            // If it hits an obsticle, reverese direction
            if node.name == "player" {
                
            }
            
            // If the moving obsticle hits the player
            if node.name == "SKSpriteNode" {
                self.reverseDirection()
            }
            return true
        } else {
            return false
        }
    }
    
    func reverseDirection() {
        if ((direction?.dy = CGFloat(1)) != nil) {
            direction?.dy = CGFloat(-1)
        } else {
            direction?.dy = CGFloat(1)
        }
    }
}
