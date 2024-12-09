//
//  GameScene.swift
//  Pong
//
//  Created by Giuseppe Cosenza on 09/12/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var impulseUnit = 20
    
    var ball = SKSpriteNode()
    var cpu = SKSpriteNode()
    var player = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        cpu = self.childNode(withName: "cpu") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: impulseUnit, dy: impulseUnit))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
