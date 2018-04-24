import UIKit
import SpriteKit
import GameplayKit

let debugMode = true

class GameViewController: UIViewController {
    
    private var gameView: SKView?
    private var currentLevel: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            gameView = view
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Level1") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
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
        currentLevel += 1
        let levelName = "Level" + String(currentLevel)
        _ = loadLevel(name: levelName)
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
