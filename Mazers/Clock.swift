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

    private var currentTime: Int
    private var startTime: Int
    private var timerStarted: Bool
    private var timeLabel: SKLabelNode?
    private var selector: MethodHandler
    private var timer: Timer?

    init(start: Int, label: SKLabelNode, selector: @escaping MethodHandler) {
        currentTime = start
        startTime = start
        timerStarted = false
        timeLabel = label
        self.selector = selector
    }
    
    func startCountdown() {
        timerStarted = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
    }
    
    func stopCountdown() {
        timer?.invalidate()
        currentTime = startTime
    }
    
    @objc func countdown() {
        currentTime -= 1
        timeLabel?.text = String(currentTime)
        
        if currentTime == 0 {
            // Call timerDone function
            stopCountdown()
            selector()
        }
    }
}
