import UIKit
import SpriteKit
import GameplayKit

let debugMode = true
let TOTAL_LEVELS = 10

class GameViewController: UIViewController {
    
    private var gameView: SKView?
    private var nextLevel: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            gameView = view
            
            self.loadNextLevel()
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = debugMode
            view.showsNodeCount = debugMode
        }
    }
    
    func setNextLevel(level: Int) {
        nextLevel = level
    }
    
    func loadLevel(name: String) -> Bool {
        if let newScene = SKScene(fileNamed: name) {
            newScene.scaleMode = .aspectFill
            gameView?.presentScene(newScene)
            return true
        } else {
            return false
        }
    }
    
    func loadNextLevel() {
        
        if nextLevel >= TOTAL_LEVELS {
            performSegue(withIdentifier: "unwindToStart", sender: self)
        }
        
        let levelName = "Level" + String(nextLevel)
        
        if Game.manager.getLevel(levelNumber: nextLevel) == nil {
            let level = LevelStats(level: nextLevel)
            Game.manager.addLevel(level: level)
        }
        
        _ = loadLevel(name: levelName)
        nextLevel += 1
    }

    override var shouldAutorotate: Bool {
        // Don't allow rotate because it breaks the game view
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
