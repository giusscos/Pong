//
//  GameScene.swift
//  Pong
//
//  Created by Giuseppe Cosenza on 09/12/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var impulseUnit = 30
    
    var ball = SKSpriteNode()
    
    var cpu = SKSpriteNode()
    var cpuLabel = SKLabelNode()
    
    var player = SKSpriteNode()
    var playerLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        cpu = self.childNode(withName: "cpu") as! SKSpriteNode
        cpu.position.y = (self.frame.height / 2) - 100
        cpuLabel = self.childNode(withName: "cpu_score") as! SKLabelNode
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        player.position.y = (-self.frame.height / 2) + 100
        playerLabel = self.childNode(withName: "player_score") as! SKLabelNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame(){
        score = [0,0]

        playerLabel.text = "\(score[0])"

        cpuLabel.text = "\(score[1])"
        
        ball.physicsBody?.applyImpulse(CGVector(dx: impulseUnit, dy: impulseUnit))
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
            
            if currentViewType == .multiPLayerView {
                if location.y > 0 {
                    cpu.run(SKAction.moveTo(x: location.x, duration: 0.1))
                } else {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            } else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentViewType == .multiPLayerView {
                if location.y > 0 {
                    cpu.run(SKAction.moveTo(x: location.x, duration: 0.1))
                } else {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            } else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentViewType {
            case .singlePlayerView:
                cpu.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
                break
            
            case .multiPLayerView:
                
                break
            
            case .settingsView:
                break
        }
        
        if ball.position.y <= (player.position.y - player.size.height) {
            addScore(playerWon: cpu)
        } else if ball.position.y >= (cpu.position.y + cpu.size.height) {
            addScore(playerWon: player)
        }
    }
}
