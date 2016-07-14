//
//  BulletSprite.swift
//  RedoArena
//
//  Created by iD Student on 7/14/16.
//  Copyright © 2016 iD Student. All rights reserved.
//

import UIKit
import SpriteKit

class BulletSprite: SKSpriteNode {

    init() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: screenWidth * 0.03, height: screenWidth * 0.03) )
    }
    
    init(player: SKSpriteNode, vector: CGVector, velocity: CGVector) {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: screenWidth * 0.03, height: screenWidth * 0.03) )
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Type.Bullet
        self.physicsBody?.contactTestBitMask = Type.Enemy
        self.physicsBody?.contactTestBitMask = Type.Border
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.position = CGPointMake(player.position.x + vector.dx*40, player.position.y + vector.dy*40)
        self.physicsBody?.velocity = velocity

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    


    
}
