//
//  GameScene.swift
//  RedoArena
//
//  Created by iD Student on 7/11/16.
//  Copyright (c) 2016 iD Student. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //MARK: SKSpriteNodes
    let player = SKSpriteNode()
    let marker = SKSpriteNode()
    var explosionObject = SKSpriteNode()
    
        //Controls
        var attackButton = SKShapeNode()
        var touchPadLarge = SKShapeNode()
        var touchPadSmall = SKShapeNode()
        var whiteBackround = SKShapeNode()
    
    
    
    
    //Mark: Variables
    var playerSpeed : CGFloat = 200
    var playerAngle : CGFloat = 0
    var speedMultiplier : CGFloat = 2
    
        //Vectors and Positions
        var touchPadX : CGFloat = 0.0
        var touchPadY : CGFloat = 0.0
        var v : CGVector = CGVectorMake(0.0, 0.0)
        var lastV : CGVector = CGVectorMake(0.0, 0.0)
    
        //Base Variables
        let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.mainScreen().bounds.width
    
        //Base Bools
        var attacked = false
        var finishedAttack = true
        var madeExplosion = false
    
  
override func didMoveToView(view: SKView) {
    
    /* Setup Base Physics */
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsBody = physicsBody
    
    
    /* Setup White Backround */
        whiteBackround = SKShapeNode(rect: CGRectMake(0, 0, screenWidth, screenHeight * 0.28))
        whiteBackround.fillColor = UIColor.whiteColor()
        whiteBackround.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, 0.0, screenWidth, screenHeight * 0.28))
        whiteBackround.physicsBody?.dynamic = false
    
        addChild(whiteBackround)
    
    
    
    /* Setup Attack Button */
        attackButton = SKShapeNode(circleOfRadius: screenWidth * 0.07)
        attackButton.position = CGPointMake(screenWidth * 0.55, screenHeight * 0.07)
        attackButton.fillColor = UIColor.grayColor()
    
        addChild(attackButton)
    
    
    
    /* Setup Large Touchpad */
        touchPadLarge = SKShapeNode(rect: CGRectMake(0, 0, screenWidth * 0.4, screenHeight * 0.25))
        touchPadLarge.fillColor = UIColor.grayColor()
        
        addChild(touchPadLarge)
    
            //Setup Touchpad Bounds
            touchPadY = touchPadLarge.frame.size.height
            touchPadX = touchPadLarge.frame.size.width
    
    
    
    /* Setup Small Touchpad */
        touchPadSmall = SKShapeNode(rect: CGRectMake(screenWidth * 0.1, screenHeight * 0.06, screenWidth * 0.2, screenHeight * 0.12))
        touchPadSmall.fillColor = UIColor.blackColor()
        
        addChild(touchPadSmall)
    
    
    
    /* Setup Player Object */
        player.size = CGSize(width: 40.0, height: 40.0)
        player.color = UIColor.blackColor()
        player.position = CGPointMake(screenWidth * 0.5, screenHeight * 0.75)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        
        addChild(player)
    
    
    
    /* Setup Marker */
        marker.size = CGSize(width: 10.0, height: 10.0)
        marker.color = UIColor.blackColor()
        marker.position = CGPointMake(touchPadX * 0.5, touchPadY * 0.5)
    
        addChild(marker)
        
   
}
    
  
    
override func update(currentTime: CFTimeInterval) {
    
    resetAngle()
    
    
/* Update Child Positions */
    if madeExplosion == true  {
    //explosionObject.position = CGPointMake(player.position.x + lastV.dx * 30, player.position.y + lastV.dy * 30)
        //explosionObject.zRotation = playerAngle
    }
    
/* Attack Function */
    if (attacked == true && finishedAttack == true) {
        
        let bleh = CGVectorMake(lastV.dx * 1500 + v.dx * 150, lastV.dy * 1500 + v.dy * 150)
        player.physicsBody?.velocity = (bleh)

        finishedAttack = false
        attack()
          
        }

/* Else Constant Movement */
    else if (attacked == false && finishedAttack == true) {
            
      player.physicsBody?.velocity = (CGVectorMake(v.dx * playerSpeed, v.dy * playerSpeed))
            
    }
       
    
}
 
    
/* Reset Vector on Touch End */
override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

    v = CGVectorMake(0.0, 0.0)
    
}

    
/* Touches Began */
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
    for touch in touches {
        
    /* Get Location of Touch */
        var location = touch.locationInView(self.view)
        location.y = screenHeight - location.y
        
        
    /* If Within Small Touchpad */
        if CGRectContainsPoint(touchPadSmall.frame, location) {
            
            v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)                    //Set, Normalize, and Save Vector
            let magnitude = sqrt(v.dx * v.dx + v.dy * v.dy)
            v = CGVectorMake(v.dx/magnitude, v.dy/magnitude)
            lastV = v
                
        }
        
            
    /* Else If Within Large Touchpad */
        else if CGRectContainsPoint(touchPadLarge.frame, location)  {
      
            v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)                    //Set, Normalize, and Save Vector
            let magnitude = sqrt(v.dx * v.dx + v.dy * v.dy)
            lastV = v
            v = CGVectorMake(v.dx/magnitude * speedMultiplier, v.dy/magnitude * speedMultiplier)                //Scale Up Vector
            
            
        }
            
         
    /* Else If Within Attack Button */
        else if CGRectContainsPoint(attackButton.frame, location)   {
           
            attacked = true
            
        }

        
    }
    
}

    
    
/* Touches Moved */
override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    for touch in touches {
        
    /* Get Location on Screen */
        var location = touch.locationInView(self.view)
        location.y = screenHeight - location.y
        
        
    /* If Within Small Touchpad */
        if CGRectContainsPoint(touchPadSmall.frame, location)   {
          
            v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)                    //Set, Normalize, and Save Vector
            let magnitude = sqrt(v.dx * v.dx + v.dy * v.dy)
            v = CGVectorMake(v.dx/magnitude, v.dy/magnitude)
            lastV = v
                
            resetAngle()                                                                                        //Reset Angle
                
        }
           
            
    /* Else If Within Large Touchpad */
        else if CGRectContainsPoint(touchPadLarge.frame, location)  {
                
            v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)                    //Set, Normalize, and Save Vector
            let magnitude = sqrt(v.dx * v.dx + v.dy * v.dy)
            v = CGVectorMake(v.dx/magnitude, v.dy/magnitude)
            lastV = v
            v = CGVectorMake(v.dx * speedMultiplier, v.dy * speedMultiplier)                                    //Scale Up Vector
            
            resetAngle()                                                                                        //Reset Angle
                
            }
            
            
            
            
        }
    }
   

/* Attack Function */
func attack(){
        
    self.explosion()                                                                                            //Call Explosion

        
    let delay = 0.05 * Double(NSEC_PER_SEC)                                                                     //Delay
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
        
        
        self.attacked = false                                                                                       //Attacked false, finished attack true
        self.finishedAttack = true
        
    }
}
    
    
/* Reset Angle */
func resetAngle(){
    
    let currentSpeed = sqrt(player.physicsBody!.velocity.dx * player.physicsBody!.velocity.dx + player.physicsBody!.velocity.dy * player.physicsBody!.velocity.dy)
    playerAngle = atan2((player.physicsBody?.velocity.dy)!, (player.physicsBody?.velocity.dx)!)
    
    
/* If Not Moving */
    if (currentSpeed > 0.01) {
        
        player.zRotation = playerAngle                                                                             //Set angle and Zero Angular Velocity
        player.physicsBody?.angularVelocity = (0.0)
        
    }
            
    
}
 
    
 
/* Explosion */
func explosion(){                                                                                                   //TODO:  sword child of player
        
        
    explosionObject = SKSpriteNode()
    explosionObject.size = CGSize(width: screenWidth * 0.05, height: screenWidth * 0.2)                             //Setup Exposion
    explosionObject.color = UIColor.redColor()
//    explosionObject.position = CGPointMake(lastV.dx * 12, lastV.dy * 12)
    explosionObject.position = CGPointMake(player.frame.width, 0)

  
        
    addChild(explosionObject)
    explosionObject.moveToParent(player)
    madeExplosion = true
    
    let delay = 0.1 * Double(NSEC_PER_SEC)                                                                            //Delay
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
        
        self.explosionObject.removeFromParent()                                                                     //Delete Explosion
        self.madeExplosion = false
            
    }

}

}