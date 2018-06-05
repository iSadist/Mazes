//
//  StartScreenViewController.swift
//  Mazers
//
//  Created by Jan Svensson on 2018-05-26.
//  Copyright © 2018 Jan Svensson. All rights reserved.
//

import UIKit
import GameKit

class StartScreenViewController: UIViewController {

    var nextVC: UIViewController? = nil
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        print("Loaded Start Screen")
    }    
    
    // MARK: UI Functions
    
    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        nextVC = segue.destination
    }
    
    @IBAction func unwindToStart(segue: UIStoryboardSegue) {
        
        if let viewController = segue.source as? LevelChooserViewController {
            // If we came from the level chooser
        } else if let viewController = segue.source as? GameViewController {
            // If we came from the game
        } else if let viewController = segue.source as? SettingsViewController {
            // If we came from the settings view
        }
        
        for level in Game.manager.completedLevels {
            print("Level " + String(level.level) + " Time: " + String(level.fastestTime!) + " Deaths: " + String(level.timesDied))
        }
    }
}
