//
//  Clock.swift
//  Mazers
//
//  Created by Jan Svensson on 2017-11-08.
//  Copyright © 2017 Jan Svensson. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

typealias MethodHandler = ()  -> Void

class Clock {

    private var currentTime: Float = 0.0
    private var timerStarted: Bool
    private var timeLabel: SKLabelNode?
    private var selector: MethodHandler
    private var timer: Timer?
    
    private var timeBefore: DispatchTime?
    private var timeAfter: DispatchTime?

    init(label: SKLabelNode, selector: @escaping MethodHandler) {
        timerStarted = false
        timeLabel = label
        self.selector = selector
    }
    
    func start() {
        timerStarted = true
        currentTime = 0.0
        timeBefore = DispatchTime.now()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.countUp), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func getCurrentTime() -> Float {
        return currentTime
    }
    
    @objc func countUp() {
        timeAfter = DispatchTime.now()
        
        if timeAfter!.uptimeNanoseconds - timeBefore!.uptimeNanoseconds >= 100000000 {
            currentTime += 0.1
            timeLabel?.text = String(currentTime)
            timeBefore = DispatchTime.now()
        }
        
        if currentTime >= 5000 {
            // Call timerDone function
            stop()
            selector()
        }
    }
}
