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
import CoreMotion

class Player: SKShapeNode {
    
    private var velocity: CGVector
    private var motionManager: CMMotionManager
    private var timer: Timer?
    private var gyroUpdateInterval = 1.0 / 60.0
    private var tiltSensitivity = Game.manager.tiltSensitivity
    
    init(rect: CGRect)
    {
        motionManager = CMMotionManager.init()
        velocity = CGVector.init(dx: 0, dy: 0)
        super.init()
        self.path = CGPath(rect: rect, transform: nil)
        
        self.becomeFirstResponder()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startGyros()
    {
        velocity = CGVector.init(dx: 0, dy: 0)
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = gyroUpdateInterval
            motionManager.startGyroUpdates()
            self.timer = Timer(fire: Date(), interval: gyroUpdateInterval, repeats: true, block: { (timer) in
                if let data = self.motionManager.gyroData {
                    let x = data.rotationRate.x
                    let y = data.rotationRate.y

                    self.velocity.dx += CGFloat(y)
                    self.velocity.dy -= CGFloat(x)
                    
                    self.updatePosition()
                }
            })
            RunLoop.current.add(self.timer!, forMode: .defaultRunLoopMode)
        } else {
            print("Gyro is not available on this device")
        }
    }
    
    func stopGyro()
    {
        if self.timer != nil
        {
            self.timer?.invalidate()
            self.timer = nil
            self.motionManager.stopGyroUpdates()
            self.velocity = CGVector.zero
        }
    }
    
    func updatePosition()
    {
        let newPosition = CGPoint.init(x: position.x + velocity.dx * CGFloat(tiltSensitivity) / 10, y: position.y + velocity.dy * CGFloat(tiltSensitivity) / 10)
        position = newPosition
    }
    
    // MARK: Touch events
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        print("Touched!")
////        touches.first?.location(in: self)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        print("Moved!")
////        self.position = (touches.first?.location(in: self))!
//    }
    
}
