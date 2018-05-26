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
    
    var gameVC: GameViewController? = nil
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        print("Loaded Start Screen")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
            gameVC = gameViewController
        }
    }
    
    // MARK: UI Functions
}
