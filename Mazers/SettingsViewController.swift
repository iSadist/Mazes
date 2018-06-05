//
//  SettingsViewController.swift
//  Mazers
//
//  Created by Jan Svensson on 2018-06-03.
//  Copyright © 2018 Jan Svensson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func tiltSensitivityChanged(_ sender: UISlider) {
        Game.manager.tiltSensitivity = Int(sender.value)
    }
    
    @IBAction func obsticleSpeedChanged(_ sender: UISlider) {
        Game.manager.obsticleSpeed = Int(sender.value)
    }
    
}
