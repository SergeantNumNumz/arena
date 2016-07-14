//
//  EnemyBulletSprite.swift
//  RedoArena
//
//  Created by iD Student on 7/14/16.
//  Copyright © 2016 iD Student. All rights reserved.
//

import UIKit
import SpriteKit

class EnemyBulletSprite: SKSpriteNode {

    init() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: screenWidth * 0.03, height: screenWidth * 0.03) )
    }
    
    init(enemy: SKSpriteNode, vector: CGVector, velocity: CGVector) {
        let screenWidth = UIScreen.mainScreen().bounds.width
        super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: screenWidth * 0.03, height: screenWidth * 0.03) )
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Type.EnemyBullet
        self.physicsBody?.contactTestBitMask = Type.Player
        self.physicsBody?.contactTestBitMask = Type.Border
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.position = CGPointMake(enemy.position.x + vector.dx*40, enemy.position.y + vector.dy*40)
        self.physicsBody?.velocity = velocity
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 
    
    
}