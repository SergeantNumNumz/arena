//
//  GameScene.swift
//  RedoArena
//
//  Created by iD Student on 7/11/16.
//  Copyright (c) 2016 iD Student. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: SKSpriteNodes
    let player = SKSpriteNode()
    let marker = SKSpriteNode()
    var swordEnemy = SKSpriteNode()
    let enemy = SKSpriteNode()
    
    
        //Controls
        var attackButton = SKShapeNode()
        var touchPadLarge = SKShapeNode()
        var touchPadSmall = SKShapeNode()
        var whiteBackround = SKShapeNode()
        var healthBarBack = SKShapeNode()
        var healthBar = SKSpriteNode()
        var enemyHealthBarBack = SKShapeNode()
        var enemyHealthBar = SKSpriteNode()
    
    
    
    
    //Mark: Variables
    var playerSpeed : CGFloat = 200
    var playerAngle : CGFloat = 0
    var speedMultiplier : CGFloat = 2
    var enemyMaxSpeed : UInt32 = 400
    var enemyMinSpeed : UInt32 = 200
    var bulletSpeed : CGFloat = 350
    
    var health : CGFloat = 0.1
    var enemyHealth : CGFloat = 0.1
    
    var enemyShootPercent : Int = 50
    var enemyMoveToPlayerPercent : Int = 15
    //var enemyRandomDirectionPercent : Int = 100

   
    
        //Vectors and Positions®
        var touchPadX : CGFloat = 0.0
        var touchPadY : CGFloat = 0.0
        var v : CGVector = CGVectorMake(0.0, 0.0)
        var lastV : CGVector = CGVectorMake(0.0, 0.0)
        var vectorToPlayer : CGVector = CGVectorMake(0.0, 0.0)
    
        //Base Variables
        let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.mainScreen().bounds.width
    
        //Base Bools
        var attacking = false
        var enemyAttacking = false
        var playerShot = false
        var madeEnemySword = false
        var enemyBusy = false
        var enemyCanAttack = true
    
    
    
    
    
  
override func didMoveToView(view: SKView) {
    
    /* Setup Base Physics */
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsBody = physicsBody
        self.physicsBody?.categoryBitMask = Type.Border
        self.physicsBody?.contactTestBitMask = Type.EnemyBullet
        self.physicsBody?.contactTestBitMask = Type.Player
        self.physicsWorld.contactDelegate = self
    self.backgroundColor = UIColor.lightGrayColor()
    
    
    /* Setup White Backround */
        whiteBackround = SKShapeNode(rect: CGRectMake(0, 0, screenWidth, screenHeight * 0.28))
        whiteBackround.fillColor = UIColor.whiteColor()
    
    
    whiteBackround.physicsBody = SKPhysicsBody(edgeLoopFromRect: whiteBackround.frame)
    
    
        //whiteBackround.physicsBody?.dynamic = false
        whiteBackround.physicsBody?.categoryBitMask = Type.Border
        whiteBackround.physicsBody?.contactTestBitMask = Type.EnemyBullet
        whiteBackround.physicsBody?.usesPreciseCollisionDetection = true
    
    
    
        addChild(whiteBackround)
    
    
    
    
    
    /* Setup Attack Button */
        attackButton = SKShapeNode(circleOfRadius: screenWidth * 0.1)
        attackButton.position = CGPointMake(screenWidth * 0.75, screenHeight * 0.1)
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
        player.size = CGSize(width: screenWidth * 0.1, height: screenWidth * 0.1)
        player.color = UIColor.blackColor()
        player.position = CGPointMake(screenWidth * 0.15, screenHeight * 0.64)
        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: screenWidth * 0.1, height: screenWidth * 0.1))
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = Type.Player
        player.physicsBody?.contactTestBitMask = Type.EnemyBullet
        player.physicsBody?.contactTestBitMask = Type.Border

        player.zPosition = 1
        
        addChild(player)
    
    
    /* Setup HealthBar  */
    
    healthBarBack = SKShapeNode(rect: CGRectMake(0, 0, screenWidth * 0.1, screenHeight * 0.01))

    
    
    healthBarBack.zPosition = 5
  
    healthBarBack.fillColor = UIColor.grayColor()
    
    addChild(healthBarBack)
    
    
    
    
    
    healthBar = SKSpriteNode()
    healthBar.size = CGSizeMake(screenWidth * 0.1, screenHeight * 0.01)
    healthBar.anchorPoint = CGPointMake(0, 0)
    healthBar.zPosition = 6
    
    healthBar.color = UIColor.greenColor()
    
    addChild(healthBar)
    
    /* Setup Enemy HealthBar  */
    
    enemyHealthBarBack = SKShapeNode(rect: CGRectMake(0, 0, screenWidth * 0.1, screenHeight * 0.01))
    
    
    
    enemyHealthBarBack.zPosition = 5
    
    enemyHealthBarBack.fillColor = UIColor.grayColor()
    
    addChild(enemyHealthBarBack)
    
    
    
    
    
    enemyHealthBar = SKSpriteNode()
    enemyHealthBar.size = CGSizeMake(screenWidth * 0.1, screenHeight * 0.01)
    enemyHealthBar.anchorPoint = CGPointMake(0, 0)
    enemyHealthBar.zPosition = 6
    
    enemyHealthBar.color = UIColor.greenColor()
    
    addChild(enemyHealthBar)
    
    /* Setup Enemy Object */
        enemy.size = CGSize(width: screenWidth * 0.1, height: screenWidth * 0.1)
        enemy.color = UIColor.redColor()
        enemy.position = CGPointMake(screenWidth * 0.85, screenHeight * 0.64)
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: screenWidth * 0.1, height: screenWidth * 0.1))
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        enemy.physicsBody?.categoryBitMask = Type.Enemy
        enemy.physicsBody?.contactTestBitMask = Type.Bullet
        enemy.physicsBody?.contactTestBitMask = Type.Border
  
    
    
        addChild(enemy)
    
    
    

    

    
    
    
    /* Setup Marker */
        marker.size = CGSize(width: 10.0, height: 10.0)
        marker.color = UIColor.blackColor()
        marker.position = CGPointMake(touchPadX * 0.5, touchPadY * 0.5)
    
        addChild(marker)
        
   
}
    
  
    
override func update(currentTime: CFTimeInterval) {
    
    
    /* HealthBar Updates */
    healthBarBack.position = CGPointMake(player.position.x - screenWidth * 0.05, player.position.y)
    
    
    //healthBar.position = CGPointMake(player.position.x, player.position.y)
    healthBar.position = healthBarBack.position
  healthBar.size = CGSizeMake(screenWidth * health, healthBar.frame.height)



    
    if health <= 0{
        
        reloadScene()
    }
  
    
    
    
    /* HealthBar Updates */
    enemyHealthBarBack.position = CGPointMake(enemy.position.x - screenWidth * 0.05, enemy.position.y)
    
    
    //healthBar.position = CGPointMake(player.position.x, player.position.y)
    enemyHealthBar.position = enemyHealthBarBack.position
    enemyHealthBar.size = CGSizeMake(screenWidth * enemyHealth, enemyHealthBar.frame.height)
    
    
    
    
    if enemyHealth <= 0{
        
        reloadScene()
    }
    
    
    vectorToPlayer = CGVectorMake(player.position.x - enemy.position.x, player.position.y - enemy.position.y)   //Set Vector to player and player angle
    let magnitude = sqrt(vectorToPlayer.dx * vectorToPlayer.dx + vectorToPlayer.dy * vectorToPlayer.dy)
    vectorToPlayer = CGVectorMake(vectorToPlayer.dx/magnitude, vectorToPlayer.dy/magnitude)
    playerAngle = atan2(vectorToPlayer.dy, vectorToPlayer.dx)
    
    
    

    resetAngle()
    
    
    if enemyBusy == false {
        enemy.zRotation = playerAngle                                                                         //Set angle and Zero Angular Velocity
        enemy.physicsBody?.angularVelocity = (0.0)
       enemyChooseAction()
        enemyBusy = true
        
    }
        
        
    else {
        
        let currentEnemyAngle = atan2((enemy.physicsBody?.velocity.dy)!, (enemy.physicsBody?.velocity.dx)!)

        enemy.zRotation = currentEnemyAngle
        
    }

    
      player.physicsBody?.velocity = (CGVectorMake(v.dx * playerSpeed, v.dy * playerSpeed))
    
   
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
           
            attack()
            
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
        // TODO: At top corner, face down and lunge. Error thrown super glitch go. Go into corner. Tap outside in direction facing the enemy. Then hit lunge
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
    
    if attacking == false {
        attacking = true
      
        
        /* Setup Player Bullets */
        let vector = scaleVector(lastV, multiplier: bulletSpeed)
        let bullet = BulletSprite(player: player, vector: lastV, velocity: vector)
        
        
        addChild(bullet)
        
//        print(scaleVector(lastV, multiplier: 300))
        
        resetPlayerAttack(0.2)
        
   
    }
  
}
    
    
/* Reset Angle */
func resetAngle(){
    
    let currentSpeed = sqrt(player.physicsBody!.velocity.dx * player.physicsBody!.velocity.dx + player.physicsBody!.velocity.dy * player.physicsBody!.velocity.dy)
    playerAngle = atan2((player.physicsBody?.velocity.dy)!, (player.physicsBody?.velocity.dx)!)
    
    
/* If Not Moving */
    if (currentSpeed > 0.01) {
        
        player.zRotation = playerAngle                                                                         //Set angle and Zero Angular Velocity
        player.physicsBody?.angularVelocity = (0.0)
        
    }
            
    
}
 

    

    
    
    
/* Enemy Choose Action */
func enemyChooseAction(){


    
/* Player Shoot Override */
if playerShot == false {
    
    
    let na = Int(arc4random_uniform(100) + 1)
    let a = enemyShootPercent                                                       //Setup probabilities
    let b = enemyMoveToPlayerPercent + enemyShootPercent
    
    
    
    
/* A */
    switch na {
        
/*1*/   case 1...a :
    
        vectorToPlayer = editRandomly(vectorToPlayer)
            enemyShoot(vectorToPlayer)
            resetEnemyBusy(0.3)
        
            
/*1*/       break
        
        
/*2*/   case a + 1...b :
            //print("Moved to Player")
            enemy.physicsBody?.velocity = scaleVector(vectorToPlayer, multiplier: CGFloat(arc4random_uniform(enemyMaxSpeed - enemyMinSpeed) + enemyMinSpeed))
            resetEnemyBusy(0.7)
            
/*2*/       break
        
        
/*3*/   case b + 1...100 :
            //print("Random Direction")
            let nb = Int(arc4random_uniform(2) + 1)
            
            switch nb
            {
                
                case 1 :
                    
                    enemy.physicsBody?.velocity = scaleVector(CGVectorMake(-vectorToPlayer.dy, vectorToPlayer.dx), multiplier: CGFloat(arc4random_uniform(enemyMaxSpeed - enemyMinSpeed) + enemyMinSpeed))
                    resetEnemyBusy(0.3)
                    
                    break
                
                case 2 :
                
                    enemy.physicsBody?.velocity = scaleVector(CGVectorMake(vectorToPlayer.dy, -vectorToPlayer.dx), multiplier: CGFloat(arc4random_uniform(enemyMaxSpeed - enemyMinSpeed) + enemyMinSpeed))
                    resetEnemyBusy(0.3)
                
                    break
                
                default:
                    break
                
            }
    
/*3*/       break
        
        
        default:
        break
        
}

} //Player shot check
    
}
    

    
    
    
func resetPlayerAttack(time : Double){
        
        let delay = time * Double(NSEC_PER_SEC)
        let beh = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(beh, dispatch_get_main_queue()) {
            
            self.attacking = false
            
        }
    
    
        
}
    
    
func enemyShoot(vector : CGVector){
    
    
    
    
    /* Setup Player Bullets */
    
    let vectora = scaleVector(vector, multiplier: bulletSpeed)
    let bullet = EnemyBulletSprite(enemy: enemy, vector: vectorToPlayer, velocity: vectora)
   
    
    addChild(bullet)
  


}
    
    
//TODO: Horizontal random doesn't work because x is increased but the y value is zero becauese its horizontal. The x is randomly increased but y remains zero therefore the angle is the same
    
    
/* Scale Vector */
func scaleVector(var vector : CGVector, multiplier : CGFloat) -> CGVector{
        
    vector = CGVectorMake(vector.dx * multiplier, vector.dy * multiplier)
    
      return vector
}
    
    func editRandomly(vector: CGVector) -> CGVector{
        
        
        let n = arc4random_uniform(2) + 1
        
        let division = CGFloat(Double(arc4random_uniform(4)) * 0.1)
        
        switch n {
            
        case 1 :
            
            return CGVectorMake(vector.dx + vector.dx*division, vector.dy - vector.dy*division)
            
         
        case 2 :
            
            return CGVectorMake(vector.dx - vector.dx*division, vector.dy + vector.dy*division)
            
            
            
        default :
            break
        }
        
        
        return         vector

    }


    
/* Function to Reset EnemyBusy after a Delay */
func resetEnemyBusy(time : Double){
        
    let delay = time * Double(NSEC_PER_SEC)
    let beh = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(beh, dispatch_get_main_queue()) {
        
        self.enemyBusy = false
        
    }
        
}
    
    
     func didBeginContact(contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let contactA = bodyA.categoryBitMask
        let contactB = bodyB.categoryBitMask
        
        
//        if contactB != Type.Player{
//        print("bodyA : \(contactA), bodyB : \(contactB)")
//        }
        
        
        switch contactA{
            
            
            
        case Type.EnemyBullet:
            
            
            
                if contactB == Type.Player
                {
                    bodyA.node?.removeFromParent()
                    //print("Enemy bullet hit player, killed bullet")
                
                }
              
//                else if contactB == Type.Bullet
//                {
//                    bodyA.node?.removeFromParent()
//                    //print("Enemy bullet hit player, killed bullet")
//                    
//                }
                
                else if contactB == Type.Border
                {
                    bodyA.node?.removeFromParent()
                    print("Enemy bullet hit border, killed bullet")
                }
                break
            
        
        case Type.Enemy:
            
            
            
            if contactB == Type.Bullet
            {
                bodyB.node?.removeFromParent()
                //print("Enemy bullet hit player, killed bullet")
                  enemyHealth -= 0.026
            }
                
          
            break
            
        case Type.Bullet:
            
            
                if contactB == Type.Enemy
                {
                    bodyA.node?.removeFromParent()
                    // print("Bullet hit enemy killed bullet")
                  
                
                }
                    
//                if contactB == Type.EnemyBullet
//                {
//                    bodyA.node?.removeFromParent()
//                    //print("Enemy bullet hit player, killed bullet")
//                    
//                }
                
                else if contactB == Type.Border
                {
                    bodyA.node?.removeFromParent()
                    print("Bullet hit border, killed ubllet")
                }
                break
            
        
            
        case Type.Border:
            
            
            if contactB == Type.EnemyBullet
            {
                bodyB.node?.removeFromParent()
                
            }
                
            else if contactB == Type.Bullet
            {
                bodyB.node?.removeFromParent()
                
            }
            break
            
            
            
        case Type.Player:
            
            
            if contactB == Type.EnemyBullet
            {
                bodyB.node?.removeFromParent()
                health -= 0.026
                
            }
                
         
            break
            
            
            
        default:
            break
        }
    }
   

    
    func reloadScene(){
        
        let nextScene = GameScene(size: scene!.size)
        
        
        scene?.view?.presentScene(nextScene)
        
    }
  

}