import UIKit
import SpriteKit
import GameplayKit

let debugMode = true

class GameViewController: UIViewController {
    
    private var gameView: SKView?
    private var nextLevel: Int = 1

    var startLevel: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            gameView = view
            
            if (startLevel != nil) {
                self.loadLevel(name: startLevel!)
            } else {
                self.loadNextLevel()
            }
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = debugMode
            view.showsNodeCount = debugMode
        }
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
        let levelName = "Level" + String(nextLevel)
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
