import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var victoryLabel : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var playerSquare : SKShapeNode?
    private var startingPosition : CGPoint?
    private var finishPosition : SKSpriteNode?
    private var squareSize : CGFloat?
    private var movingSquare : Bool = false
    private var obsticles : [SKSpriteNode] = []
    private var movingObsticles : [MovingObsticle] = []
    private var gameStarted = false
    private var timeLimit = 300
    private var clock: Clock?
    
    override func didMove(to view: SKView) {
        finishPosition = self.childNode(withName: "finishPosition") as! SKSpriteNode?
        // Get label node from scene and store it for use later
        victoryLabel = self.childNode(withName: "victoryLabel") as? SKLabelNode
        if let label = self.victoryLabel {
            label.alpha = 0.0
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            spinnyNode.fillColor = UIColor.blue
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5)))
            spinnyNode.run(SKAction.repeatForever(SKAction.scale(by: 0.1, duration: 0.5)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.25),
                                              SKAction.fadeOut(withDuration: 0.25),
                                              SKAction.removeFromParent()]))
        }
        
        squareSize = w
        
        self.storeObsticles()
        self.storeMovingObsticles()
        
        self.createPlayer()
    }
    
    // MARK: Touch events
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.isInsideSquare(other: (playerSquare?.position)!, size: squareSize!) {
            movingSquare = true
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if movingSquare {
            if !gameStarted {
                startTheGame()
            }
            
            // Create a stream after the square
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
            
            // Move the square
            let newPoint = CGPoint.init(x: pos.x - squareSize!/2, y: pos.y - squareSize!/2)
            playerSquare?.position = newPoint
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        movingSquare = false
    }
    
    // MARK: Game functions
    
    func startTheGame() {
        gameStarted = true
        if let timeLabel = self.childNode(withName: "timerLabel") as! SKLabelNode? {
            let clock = Clock(start: timeLimit, label: timeLabel, selector: {
                self.terminateLevel()
            })
            clock.startCountdown()
            self.clock = clock
        }
    }
    
    func levelCompleted() {
        // Display a victory message
        victoryLabel?.run(SKAction.fadeIn(withDuration: 1))
        self.clock?.stopCountdown()
        self.loadNextLevel()
    }
    
    @objc func loadNextLevel() {
        // Load next level
        if let startScreenVC = self.view?.window?.rootViewController as? StartScreenViewController {
            
            if let gameVC = startScreenVC.nextVC as? GameViewController {
                gameVC.loadNextLevel()
            }
            
            if let levelChooserVC = startScreenVC.nextVC as? LevelChooserViewController {
                // Perform unwind segue
                levelChooserVC.gameVC?.performSegue(withIdentifier: "unwindToStart", sender: nil)
            }
        }

    }

    @objc func terminateLevel() {
        gameStarted = false
        movingSquare = false
        playerSquare?.position = startingPosition!
        self.clock?.stopCountdown()
    }
    
    func didCollisionOccur() -> Bool {
        for obsticle in obsticles {
            if obsticle.intersects(playerSquare!) {
                return true
            }
            
            for movingObsticle in movingObsticles {
                movingObsticle.intersects(obsticle)
                if movingObsticle.intersects(playerSquare!) {
                    return true
                }
            }
        }
        return false
    }
    
    func didPassFinishLine() {
        if (playerSquare?.intersects(finishPosition!))! {
            levelCompleted()
        }
    }
    
    func storeObsticles() {
        let obsticleNodes = self.children.filter({ (node) -> Bool in
            return node.name == "SKSpriteNode"
        })
        
        for obsticle in obsticleNodes {
            obsticles.append(obsticle as! SKSpriteNode)
        }
    }
    
    func storeMovingObsticles() {
        let movingObsticleNodes = self.children.filter({ (node) -> Bool in
            return node.name == "movingObsticle"
        })
        
        for obsticle in movingObsticleNodes {
            let movingObsticle = MovingObsticle.init(rect: obsticle.frame)
            movingObsticle.fillColor = UIColor.red
            movingObsticles.append(movingObsticle)
            self.addChild(movingObsticle)
            
            obsticle.removeFromParent()
        }
    }
    
    func createPlayer() {
        // Set start position
        if let startPosition = self.childNode(withName: "startPosition") as! SKSpriteNode? {
            // Let the starting position be determined by the sks file
            self.startingPosition = startPosition.position
            startPosition.removeFromParent()
        }
        
        let rect = CGRect.init(x: 0, y: 0, width: squareSize!, height: squareSize!)
        self.playerSquare = SKShapeNode.init(rect: rect)
        if let squareNode = self.playerSquare {
            squareNode.name = "player"
            squareNode.position = startingPosition!
            squareNode.fillColor = UIColor.blue
        }
        
        self.addChild(playerSquare!)
    }
    
    // MARK: Class functions

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        didPassFinishLine()

        if didCollisionOccur() {
            terminateLevel()
        }
        
        for movingObsticle in movingObsticles {
            movingObsticle.takeStep()
        }
    }
}

extension CGPoint {
    func isInsideSquare(other: CGPoint, size: CGFloat) -> Bool {
        let horizontal = self.x > other.x && self.x < other.x + size
        let vertical = self.y > other.y && self.y < other.y + size
        return horizontal && vertical
    }
}
