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

class MovingObsticle: SKShapeNode {
    
    private var direction: CGVector = CGVector.init(dx: 1, dy: 0)
    private var velocity: CGFloat = 3
    
    init(rect: CGRect){
        super.init()
        
        self.path = CGPath(rect: rect, transform: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeStep () {
        self.position.x += direction.dx * velocity
        self.position.y += direction.dy * velocity
        
        // Prevent the square from going outside the screen
    }
    
    func setDirection (direction: CGVector) {
        self.direction = direction
    }
    
    func setSpeed (speed: CGFloat) {
        self.velocity = speed
    }
    
    override func intersects(_ node: SKNode) -> Bool {
        if node.intersects(self) {
            switch node.name {
              case "player":
                return true
              case "SKSpriteNode":
                self.reverseDirection()
                return false
              default:
                return false
            }
        } else {
            return false
        }
    }
    
    func reverseDirection() {
        direction.dx = -direction.dx
        direction.dy = -direction.dy
    }
}
