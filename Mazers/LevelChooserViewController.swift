//
//  LevelChooserViewController.swift
//  Mazers
//
//  Created by Jan Svensson on 2018-05-26.
//  Copyright © 2018 Jan Svensson. All rights reserved.
//

import UIKit
import GameKit

class LevelChooserViewController: UIViewController {
    
    var chosenLevel: String = ""
    var gameVC: GameViewController? = nil
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        
    }
    
    // MARK: UI Functions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let levelName = sender.currentTitle
        chosenLevel = levelName!
        performSegue(withIdentifier: "segueToGameView", sender: self)
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
            gameViewController.setNextLevel(level: Int(chosenLevel.dropFirst(5))!)
            gameVC = gameViewController
        }
    }
    
    @IBAction func unwindToLevelChooser(segue: UIStoryboardSegue) {
        print("Unwind segue to level chooser")
    }
}
