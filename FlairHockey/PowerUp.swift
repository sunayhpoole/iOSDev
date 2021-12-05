//
//  PowerUp.swift
//  FlairHockey
//
//  Created by Riddhi Bagadiaa on 05/05/19.
//  Copyright © 2019 Planets. All rights reserved.
//

/*import Foundation
import SpriteKit
import GameplayKit

class PowerUp {
    
    var powerupType: String
    var imageName: String
    var powerUpCollectible: SKSpriteNode
    var field: SKFieldNode
    
    
    init() {
        powerUpCollectible = SKSpriteNode()
        field = SKFieldNode()
    }
    
    
    
}

class SpringField: PowerUp {
    override init() {
        powerUpCollectible = SKSpriteNode(imageNamed: "springField")
        powerUpCollectible = makePowerUpCollectible()
        field = SKFieldNode.springField()
        
    }
    
    func makePowerUpCollectible() -> SKSpriteNode {
        powerUpCollectible.size.width = 50
        powerUpCollectible.size.height = 50
        powerUpCollectible.color = .red
        powerUpCollectible.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUpCollectible.physicsBody?.isDynamic = false
        powerUpCollectible.physicsBody?.allowsRotation = false
        powerUpCollectible.physicsBody?.affectedByGravity = false
        powerUpCollectible.physicsBody?.restitution = 0
        powerUpCollectible.physicsBody?.friction = 0
        powerUpCollectible.physicsBody?.categoryBitMask = 7
        powerUpCollectible.physicsBody?.fieldBitMask = 0
        powerUpCollectible.physicsBody?.contactTestBitMask = 2
        powerUpCollectible.physicsBody?.mass = 1000
        powerUpCollectible.physicsBody?.linearDamping = 0
        powerUpCollectible.physicsBody?.angularDamping = 0
        return powerUpCollectible
    }
    
    
}




class GravityField: PowerUp {
    override init() {
        powerUpCollectible = SKSpriteNode(imageNamed: "gravityField")
        powerUpCollectible = makePowerUpCollectible()
        field = SKFieldNode.radialGravityField()
        
    }
    
    func makePowerUpCollectible() -> SKSpriteNode {
        powerUpCollectible.size.width = 50
        powerUpCollectible.size.height = 50
        powerUpCollectible.color = .red
        powerUpCollectible.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUpCollectible.physicsBody?.isDynamic = false
        powerUpCollectible.physicsBody?.allowsRotation = false
        powerUpCollectible.physicsBody?.affectedByGravity = false
        powerUpCollectible.physicsBody?.restitution = 0
        powerUpCollectible.physicsBody?.friction = 0
        powerUpCollectible.physicsBody?.categoryBitMask = 7
        powerUpCollectible.physicsBody?.fieldBitMask = 0
        powerUpCollectible.physicsBody?.contactTestBitMask = 2
        powerUpCollectible.physicsBody?.mass = 1000
        powerUpCollectible.physicsBody?.linearDamping = 0
        powerUpCollectible.physicsBody?.angularDamping = 0
        return powerUpCollectible
    }
}



class FrictionField: PowerUp {
    override init() {
        powerUpCollectible = SKSpriteNode(imageNamed: "frictionField")
        powerUpCollectible = makePowerUpCollectible()
        
    }
    
    func makePowerUpCollectible() -> SKSpriteNode {
        powerUpCollectible.size.width = 50
        powerUpCollectible.size.height = 50
        powerUpCollectible.color = .red
        powerUpCollectible.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUpCollectible.physicsBody?.isDynamic = false
        powerUpCollectible.physicsBody?.allowsRotation = false
        powerUpCollectible.physicsBody?.affectedByGravity = false
        powerUpCollectible.physicsBody?.restitution = 0
        powerUpCollectible.physicsBody?.friction = 0
        powerUpCollectible.physicsBody?.categoryBitMask = 7
        powerUpCollectible.physicsBody?.fieldBitMask = 0
        powerUpCollectible.physicsBody?.contactTestBitMask = 2
        powerUpCollectible.physicsBody?.mass = 1000
        powerUpCollectible.physicsBody?.linearDamping = 0
        powerUpCollectible.physicsBody?.angularDamping = 0
        return powerUpCollectible
    }
}



class FreezeField: PowerUp {
    override init() {
        powerUpCollectible = SKSpriteNode(imageNamed: "freezeField")
        powerUpCollectible = makePowerUpCollectible()
        
    }
    
    func makePowerUpCollectible() -> SKSpriteNode {
        powerUpCollectible.size.width = 50
        powerUpCollectible.size.height = 50
        powerUpCollectible.color = .red
        powerUpCollectible.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUpCollectible.physicsBody?.isDynamic = false
        powerUpCollectible.physicsBody?.allowsRotation = false
        powerUpCollectible.physicsBody?.affectedByGravity = false
        powerUpCollectible.physicsBody?.restitution = 0
        powerUpCollectible.physicsBody?.friction = 0
        powerUpCollectible.physicsBody?.categoryBitMask = 7
        powerUpCollectible.physicsBody?.fieldBitMask = 0
        powerUpCollectible.physicsBody?.contactTestBitMask = 2
        powerUpCollectible.physicsBody?.mass = 1000
        powerUpCollectible.physicsBody?.linearDamping = 0
        powerUpCollectible.physicsBody?.angularDamping = 0
        return powerUpCollectible
    }
}

    //var SpriteNode
    //collideMethods
    
    
    func defineGenericPUforPB() -> SKSpriteNode {
        var genericPowerUp = SKSpriteNode()
        genericPowerUp.size.width = 10
        genericPowerUp.size.height = 10
        
        genericPowerUp.color = .red
        
        genericPowerUp.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        
        genericPowerUp.physicsBody?.isDynamic = false
        genericPowerUp.physicsBody?.allowsRotation = false
        genericPowerUp.physicsBody?.affectedByGravity = false
        genericPowerUp.physicsBody?.restitution = 0
        genericPowerUp.physicsBody?.friction = 0
        genericPowerUp.physicsBody?.categoryBitMask = 7
        genericPowerUp.physicsBody?.fieldBitMask = 0
        genericPowerUp.physicsBody?.contactTestBitMask = 2
        genericPowerUp.physicsBody?.mass = 1000
        genericPowerUp.physicsBody?.linearDamping = 0
        genericPowerUp.physicsBody?.angularDamping = 0
        
        return genericPowerUp
    }
    
    func choosePowerUp(){
        
        // choose random index later
        currentPowerUp = powerUps[0]
        currentPowerUp.position.x = 85
        currentPowerUp.position.y = 300
        addChild(currentPowerUp)
        
        //var colorify = SKAction.colorize(with: .red, colorBlendFactor: 5.0, duration: 3)
        
        //currentPowerUp.run(SKAction.sequence([colorify]))
        // chooses random power up from powerUps array
        // assigns random position to powerUp
        // calls addChild on powerUp
        
    }

//done
/*
    func definePowerUps() {
        
        //var onePowerUp = defineGenericPowerUp()
        //use this one in the future
        var onePowerUp = SKSpriteNode(imageNamed: "springField")
        onePowerUp.size.width = 30
        onePowerUp.size.height = 30
        
        onePowerUp.color = .red
        
        onePowerUp.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        
        onePowerUp.physicsBody?.isDynamic = false
        onePowerUp.physicsBody?.allowsRotation = false
        onePowerUp.physicsBody?.affectedByGravity = false
        onePowerUp.physicsBody?.restitution = 0
        onePowerUp.physicsBody?.friction = 0
        onePowerUp.physicsBody?.categoryBitMask = 7
        onePowerUp.physicsBody?.fieldBitMask = 0
        onePowerUp.physicsBody?.contactTestBitMask = 2
        onePowerUp.physicsBody?.mass = 1000
        onePowerUp.physicsBody?.linearDamping = 0
        onePowerUp.physicsBody?.angularDamping = 0
        
        //currentPowerUp = onePowerUp
        powerUps.append(onePowerUp)
        
        // gets called once in the setup function
        // puts all the powerups into the array
        //powerUps[0] = makeSpringPowerUp()
        
    }
 */
    
    // makePowerUp functions initialize SpriteNode and give physical characteristics
    /*func makeSpringPowerUp() -> SKSpriteNode {
     
     var springPowerUp = SKSpriteNode()
     springPowerUp.size.width = 10
     springPowerUp.size.height = 10
     springPowerUp.color = .red
     // assign spring picture
     
     springPowerUp.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
     springPowerUp.physicsBody?.categoryBitMask = 7
     springPowerUp.physicsBody?.contactTestBitMask = 2
     springPowerUp.physicsBody?.isDynamic = false
     
     return springPowerUp
     } */
    
    /*func didCollideWithPowerUp(powerUp: SKSpriteNode) {
     
     // add more later
     didCollideWithSpringPowerUp()
     
     } */
    

   */

