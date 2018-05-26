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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
            gameViewController.startLevel = chosenLevel
        }
    }
}
