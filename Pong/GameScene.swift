//
//  GameScene.swift
//  Pong
//
//  Created by Giuseppe Cosenza on 09/12/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var impulseUnit = 50
    
    var ball = SKSpriteNode()
    
    var cpu = SKSpriteNode()
    var cpuLabel = SKLabelNode()
    
    var player = SKSpriteNode()
    var playerLabel = SKLabelNode()

    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        cpu = self.childNode(withName: "cpu") as! SKSpriteNode
        cpuLabel = self.childNode(withName: "cpu_score") as! SKLabelNode
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        playerLabel = self.childNode(withName: "player_score") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: impulseUnit, dy: impulseUnit))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    func startGame(){
        score = [0,0]

        playerLabel.text = "\(score[0])"

        cpuLabel.text = "\(score[1])"
    }
    
    func addScore(playerWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWon == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: impulseUnit, dy: impulseUnit))
        } else if playerWon == cpu {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: (impulseUnit * -1), dy: (impulseUnit * -1)))
        }
        
        playerLabel.text = "\(score[0])"
        
        cpuLabel.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        cpu.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        
        if ball.position.y <= (player.position.y - player.size.height) {
            addScore(playerWon: cpu)
        } else if ball.position.y >= (cpu.position.y + cpu.size.height) {
            addScore(playerWon: player)
        }
    }
}
