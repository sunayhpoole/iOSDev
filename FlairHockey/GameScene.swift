//
//  GameScene.swift
//  FlairHockey
//
//  Created by Riddhi Bagadiaa on 18/04/19.
//  Copyright © 2019 Planets. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var sunayBall = SKShapeNode(circleOfRadius: 60)
    
    var riddhiPaddleSize = CGFloat(75);
    var riddhiPaddle = SKShapeNode(circleOfRadius: 75)
    var sunayPaddleSize = CGFloat(75);
    var sunayPaddle = SKShapeNode(circleOfRadius: 75)
    var riddhiFrozenPaddle = false
    var sunayFrozenPaddle = false
    
    var sunayGoal = SKSpriteNode()
    var riddhiGoal = SKSpriteNode()
    var sunayGoalField = SKFieldNode()
    var riddhiGoalField = SKFieldNode()
    
    var sunayHalf = SKFieldNode()
    var riddhiHalf = SKFieldNode()
    
    let centerLine = SKSpriteNode()
    
    var lastPaddleHit = SKShapeNode()
    
    var powerUps: [SKSpriteNode] = []
    var currentPowerUp = SKSpriteNode()
    var score: [Int] = []
    var randomPowerUpNum = 0
    
    var powerUpIsActive = false
    
    var sunayScore = SKLabelNode()
    var riddhiScore = SKLabelNode()
    
    var riddhiPaddleLastLocation = CGPoint(x: 0, y: -550)
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(displayP3Red: 230.0 / 255, green: 255.0 / 255, blue: 253.0 / 255, alpha: 1)
        
        setUpFields()
        makePaddleAndPuck()
        setUpGoal()
        
        addChild(sunayBall)
        addChild(riddhiPaddle)
        addChild(sunayPaddle)
        addChild(sunayGoal)
        addChild(riddhiGoal)
        addChild(sunayHalf)
        addChild(riddhiHalf)
        
        var centreCircle = SKShapeNode(circleOfRadius: 90)
        centreCircle.glowWidth = 3.0
        centreCircle.strokeColor = .blue
        centreCircle.position.x = 0
        centreCircle.position.y = 0
        addChild(centreCircle)
        
        var goalBox = SKShapeNode(rectOf: CGSize(width: 600, height: 120))
        goalBox.position.x = 0
        goalBox.position.y = self.frame.height/2
        goalBox.glowWidth = 3.0
        goalBox.strokeColor = .blue
        addChild(goalBox)
        
        var goalBox1 = SKShapeNode(rectOf: CGSize(width: 600, height: 120))
        goalBox1.position.x = 0
        goalBox1.position.y = -self.frame.height/2
        goalBox1.glowWidth = 3.0
        goalBox1.strokeColor = .blue
        addChild(goalBox1)
        
        
        addBorderAndLine()
        startGame()
        makePowerUps()
        
        choosePowerUp()
        
        sunayBall.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        physicsWorld.contactDelegate = self
        
        let delay = SKAction.wait(forDuration: 14.0)
        
        run(SKAction.repeatForever(
            SKAction.sequence([delay, SKAction.run(choosePowerUp)])
        ))
    }
    
    func startGame() {
        
        score = [0, 0]
        var sunayString = String(score[1])
        sunayScore.text = sunayString
        sunayScore.fontColor = .black
        sunayScore.fontName = "MarkerFelt-Wide"
        sunayScore.fontSize = 96
        sunayScore.position = CGPoint(x: self.frame.width/2 - 30, y: 40)
        sunayScore.horizontalAlignmentMode = .right
        
        var riddhiString = String(score[0])
        riddhiScore.text = riddhiString
        riddhiScore.fontColor = .black
        riddhiScore.fontName = "MarkerFelt-Wide"
        riddhiScore.fontSize = 96
        riddhiScore.position = CGPoint(x: self.frame.width/2 - 30, y: -90)
        riddhiScore.horizontalAlignmentMode = .right
        
        addChild(sunayScore)
        addChild(riddhiScore)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            riddhiPaddleLastLocation = riddhiPaddle.position
            if riddhiFrozenPaddle == false {
                if ((location.y + riddhiPaddleSize) < 0) {
                    riddhiPaddle.run(SKAction.move(to: location, duration: 0.2))
                } else {
                    riddhiPaddle.run(SKAction.move(to: CGPoint(x: location.x, y: 0), duration: 0.2))
                }
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            riddhiPaddleLastLocation = riddhiPaddle.position
            if riddhiFrozenPaddle == false {
                if ((location.y + riddhiPaddleSize) < 0) {
                    riddhiPaddle.run(SKAction.move(to: location, duration: 0.2))
                } else {
                    riddhiPaddle.run(SKAction.move(to: CGPoint(x: location.x, y: -riddhiPaddleSize), duration: 0.2))
                }
            }
        }
    }
    
    func addScore(winner: SKShapeNode) {
        
        if winner == riddhiPaddle {
            riddhiScore.removeFromParent()
            score[0] += 1
            var riddhiString = String(score[0])
            riddhiScore.text = riddhiString
            addChild(riddhiScore)
        } else if winner == sunayPaddle {
            sunayScore.removeFromParent()
            score[1] += 1
            var sunayString = String(score[1])
            sunayScore.text = sunayString
            addChild(sunayScore)
        }
        
        print(score)
        
    }
    
    func addBorderAndLine() {
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.categoryBitMask = 1
        border.collisionBitMask = 2 | 1
        border.fieldBitMask = 0
        //border.contactTestBitMask = 2
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        centerLine.size.width = self.frame.width
        centerLine.size.height = 5
        centerLine.position.x = 0
        centerLine.position.y = 0
        
        centerLine.color = .black
        addChild(centerLine)
    }
    
    func setUpGoal() {
        sunayGoal.size.width = 200
        sunayGoal.size.height = 30
        riddhiGoal.size.width = 200
        riddhiGoal.size.height = 30
        sunayGoal.position.x = 0
        sunayGoal.position.y = self.frame.height/2
        riddhiGoal.position.x = 0
        riddhiGoal.position.y = -self.frame.height/2
        sunayGoal.color = .black
        riddhiGoal.color = .black
        
        sunayGoal.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 30))
        riddhiGoal.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 30))
        
        sunayGoal.physicsBody?.isDynamic = false
        sunayGoal.physicsBody?.allowsRotation = false
        sunayGoal.physicsBody?.affectedByGravity = false
        sunayGoal.physicsBody?.restitution = 0
        sunayGoal.physicsBody?.friction = 0
        sunayGoal.physicsBody?.categoryBitMask = 3
        sunayGoal.physicsBody?.collisionBitMask = 1
        sunayGoal.physicsBody?.fieldBitMask = 0
        sunayGoal.physicsBody?.contactTestBitMask = 2
        sunayGoal.physicsBody?.mass = 1000
        sunayGoal.physicsBody?.linearDamping = 0
        sunayGoal.physicsBody?.angularDamping = 0
        
        riddhiGoal.physicsBody?.isDynamic = false
        riddhiGoal.physicsBody?.allowsRotation = false
        riddhiGoal.physicsBody?.affectedByGravity = false
        riddhiGoal.physicsBody?.restitution = 0
        riddhiGoal.physicsBody?.friction = 0
        riddhiGoal.physicsBody?.categoryBitMask = 3
        riddhiGoal.physicsBody?.collisionBitMask = 1
        riddhiGoal.physicsBody?.fieldBitMask = 0
        riddhiGoal.physicsBody?.contactTestBitMask = 2
        riddhiGoal.physicsBody?.mass = 1000
        riddhiGoal.physicsBody?.linearDamping = 0
        riddhiGoal.physicsBody?.angularDamping = 0
        
    }
    
    func makePaddleAndPuck() {
        riddhiPaddle.position.x = 0
        riddhiPaddle.position.y = -550
        riddhiPaddle.strokeColor = SKColor.black
        riddhiPaddle.glowWidth = 3.0
        riddhiPaddle.fillColor = SKColor.white
        
        sunayPaddle.position.x = 0
        sunayPaddle.position.y = 550
        sunayPaddle.strokeColor = SKColor.black
        sunayPaddle.glowWidth = 3.0
        sunayPaddle.fillColor = SKColor.white
        
        riddhiPaddle.physicsBody = SKPhysicsBody(circleOfRadius:75)
        sunayPaddle.physicsBody = SKPhysicsBody(circleOfRadius:75)
        
        riddhiPaddle.physicsBody?.isDynamic = false
        riddhiPaddle.physicsBody?.allowsRotation = false
        riddhiPaddle.physicsBody?.affectedByGravity = false
        riddhiPaddle.physicsBody?.restitution = 0.5
        riddhiPaddle.physicsBody?.friction = 0
        riddhiPaddle.physicsBody?.categoryBitMask = 1
        riddhiPaddle.physicsBody?.collisionBitMask = 1 | 2 | 3 | 6
        riddhiPaddle.physicsBody?.fieldBitMask = 0
        riddhiPaddle.physicsBody?.contactTestBitMask = 2 | 3 | 6
        riddhiPaddle.physicsBody?.mass = 11
        
        sunayPaddle.physicsBody?.isDynamic = false
        sunayPaddle.physicsBody?.allowsRotation = false
        sunayPaddle.physicsBody?.affectedByGravity = false
        sunayPaddle.physicsBody?.restitution = 0.5
        sunayPaddle.physicsBody?.friction = 0
        sunayPaddle.physicsBody?.categoryBitMask = 1
        sunayPaddle.physicsBody?.collisionBitMask = 1 | 2 | 3 | 6
        sunayPaddle.physicsBody?.fieldBitMask = 0
        sunayPaddle.physicsBody?.contactTestBitMask = 2 | 3 | 6
        sunayPaddle.physicsBody?.mass = 10
        
        sunayBall.position.x = 0
        sunayBall.position.y = 0
        sunayBall.strokeColor = SKColor.black
        sunayBall.glowWidth = 1.0
        sunayBall.fillColor = SKColor.yellow
        
        
        sunayBall.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        sunayBall.physicsBody?.isDynamic = true
        sunayBall.physicsBody?.allowsRotation = false
        sunayBall.physicsBody?.affectedByGravity = false
        sunayBall.physicsBody?.restitution = 1
        sunayBall.physicsBody?.friction = 0
        sunayBall.physicsBody?.categoryBitMask = 2
        sunayBall.physicsBody?.collisionBitMask = 1 | 9
        sunayBall.physicsBody?.fieldBitMask = 5 | 8
        sunayBall.physicsBody?.contactTestBitMask = 1 | 3 | 7 | 9
        sunayBall.physicsBody?.mass = 0.07
        sunayBall.physicsBody?.linearDamping = 0
        sunayBall.physicsBody?.angularDamping = 0
    }
    
    func choosePowerUp() {
        if (powerUpIsActive == false) {
            randomPowerUpNum = Int.random(in: 0...4)
            currentPowerUp = powerUps[randomPowerUpNum]
            let left = -self.frame.width/2 + 30
            let right = self.frame.width/2 - 30
            currentPowerUp.position.x = CGFloat.random(in: left...right)
            let up = self.frame.height/2 - 30
            let down = -self.frame.height/2 + 30
            currentPowerUp.position.y = CGFloat.random(in: down...up)
            powerUpIsActive = true
            addChild(currentPowerUp)
        }
    }
    
    func makePowerUps() {
        var powerUp0 = SKSpriteNode(imageNamed: "springField")
        powerUp0.size.width = 50
        powerUp0.size.height = 50
        powerUp0.color = .red
        powerUp0.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUp0.physicsBody?.isDynamic = false
        powerUp0.physicsBody?.allowsRotation = false
        powerUp0.physicsBody?.affectedByGravity = false
        powerUp0.physicsBody?.restitution = 0
        powerUp0.physicsBody?.friction = 0
        powerUp0.physicsBody?.categoryBitMask = 7
        powerUp0.physicsBody?.fieldBitMask = 0
        powerUp0.physicsBody?.collisionBitMask = 0
        powerUp0.physicsBody?.contactTestBitMask = 2
        powerUp0.physicsBody?.mass = 1000
        powerUp0.physicsBody?.linearDamping = 0
        powerUp0.physicsBody?.angularDamping = 0
        
        powerUps.append(powerUp0)
        
        var powerUp1 = SKSpriteNode(imageNamed: "gravityPowerUp")
        powerUp1.size.width = 50
        powerUp1.size.height = 50
        powerUp1.color = .red
        powerUp1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUp1.physicsBody?.isDynamic = false
        powerUp1.physicsBody?.allowsRotation = false
        powerUp1.physicsBody?.affectedByGravity = false
        powerUp1.physicsBody?.restitution = 0
        powerUp1.physicsBody?.friction = 0
        powerUp1.physicsBody?.categoryBitMask = 7
        powerUp1.physicsBody?.fieldBitMask = 0
        powerUp1.physicsBody?.collisionBitMask = 0
        powerUp1.physicsBody?.contactTestBitMask = 2
        powerUp1.physicsBody?.mass = 1000
        powerUp1.physicsBody?.linearDamping = 0
        powerUp1.physicsBody?.angularDamping = 0
        
        powerUps.append(powerUp1)
        
        var powerUp2 = SKSpriteNode(imageNamed: "protectGoalPowerUp")
        powerUp2.size.width = 50
        powerUp2.size.height = 50
        powerUp2.color = .red
        powerUp2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUp2.physicsBody?.isDynamic = false
        powerUp2.physicsBody?.allowsRotation = false
        powerUp2.physicsBody?.affectedByGravity = false
        powerUp2.physicsBody?.restitution = 0
        powerUp2.physicsBody?.friction = 0
        powerUp2.physicsBody?.categoryBitMask = 7
        powerUp2.physicsBody?.fieldBitMask = 0
        powerUp2.physicsBody?.collisionBitMask = 0
        powerUp2.physicsBody?.contactTestBitMask = 2
        powerUp2.physicsBody?.mass = 1000
        powerUp2.physicsBody?.linearDamping = 0
        powerUp2.physicsBody?.angularDamping = 0
        
        powerUps.append(powerUp2)
        
        var powerUp3 = SKSpriteNode(imageNamed: "freezePowerUp")
        powerUp3.size.width = 50
        powerUp3.size.height = 50
        powerUp3.color = .red
        powerUp3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUp3.physicsBody?.isDynamic = false
        powerUp3.physicsBody?.allowsRotation = false
        powerUp3.physicsBody?.affectedByGravity = false
        powerUp3.physicsBody?.restitution = 0
        powerUp3.physicsBody?.friction = 0
        powerUp3.physicsBody?.categoryBitMask = 7
        powerUp3.physicsBody?.fieldBitMask = 0
        powerUp3.physicsBody?.collisionBitMask = 0
        powerUp3.physicsBody?.contactTestBitMask = 2
        powerUp3.physicsBody?.mass = 1000
        powerUp3.physicsBody?.linearDamping = 0
        powerUp3.physicsBody?.angularDamping = 0
        
        powerUps.append(powerUp3)
        
        var powerUp4 = SKSpriteNode(imageNamed: "mysteryPowerUp")
        powerUp4.size.width = 50
        powerUp4.size.height = 50
        powerUp4.color = .red
        powerUp4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        powerUp4.physicsBody?.isDynamic = false
        powerUp4.physicsBody?.allowsRotation = false
        powerUp4.physicsBody?.affectedByGravity = false
        powerUp4.physicsBody?.restitution = 0
        powerUp4.physicsBody?.friction = 0
        powerUp4.physicsBody?.categoryBitMask = 7
        powerUp4.physicsBody?.fieldBitMask = 0
        powerUp4.physicsBody?.collisionBitMask = 0
        powerUp4.physicsBody?.contactTestBitMask = 2
        powerUp4.physicsBody?.mass = 1000
        powerUp4.physicsBody?.linearDamping = 0
        powerUp4.physicsBody?.angularDamping = 0
        
        powerUps.append(powerUp4)

        //currentPowerUp.position.x = 85
        //currentPowerUp.position.y = 300
    }
    
    
    func setUpFields() {
        
        sunayHalf.categoryBitMask = 5
        sunayHalf.region = SKRegion(size: CGSize(width: self.frame.width, height: self.frame.height/2))
        sunayHalf.position = CGPoint(x: 0, y: self.frame.height/4)
        sunayHalf.strength = 0.75
        
        riddhiHalf.categoryBitMask = 5
        riddhiHalf.region = SKRegion(size: CGSize(width: self.frame.width, height: self.frame.height/2))
        riddhiHalf.position = CGPoint(x: 0, y: -self.frame.height/4)
        riddhiHalf.strength = 0.75
        
        sunayHalf.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height/2), center: CGPoint(x: 0, y: self.frame.height/4))
        riddhiHalf.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height/2), center: CGPoint(x: 0, y: -self.frame.height/4))
        sunayHalf.physicsBody?.friction = 0.9
        riddhiHalf.physicsBody?.friction = 0.9
        sunayHalf.isEnabled = true
        riddhiHalf.isEnabled = true
        
    }
    
    func callCollideFunction(powerUpNum: Int) {
        let number = powerUpNum
        switch number{
        case 0:
            didCollideWithSpringPU()
        case 1:
            didCollideWithGravityPU()
        case 2:
            didCollideWithGoalProtectorPU()
        case 3:
            didCollideWithFreezePU()
        case 4:
            //pick random number and call this function again with that number
            var randomNum = Int.random(in: 0...3)
            callCollideFunction(powerUpNum: randomNum)
        default:
            break
        }
    }
    
    func didCollideWithSpringPU() {
        sunayHalf.removeFromParent()
        riddhiHalf.removeFromParent()
        
        if lastPaddleHit == riddhiPaddle {
            sunayHalf = SKFieldNode.springField()
            setUpFields()
        } else if lastPaddleHit == sunayPaddle {
            riddhiHalf = SKFieldNode.springField()
            setUpFields()
        }
        
        addChild(sunayHalf)
        addChild(riddhiHalf)
        
        //let delay = SKAction.wait(forDuration: 7.0)
        //run(delay)
        centerLine.run(SKAction.wait(forDuration: 7))
        
        sunayHalf.removeFromParent()
        riddhiHalf.removeFromParent()
        setUpFields()
        addChild(sunayHalf)
        addChild(riddhiHalf)
        powerUpIsActive = false
    }
    
    func didCollideWithGravityPU() {
        var sunay = false
        var riddhi = false
        
        if lastPaddleHit == riddhiPaddle {
            sunayGoalField = SKFieldNode.radialGravityField()
            sunayGoalField.categoryBitMask = 8
            sunayGoalField.region = SKRegion(size: CGSize(width: 200, height: 30))
            sunayGoalField.position = CGPoint(x: 0, y: self.frame.height/2)
            sunayGoalField.strength = 10
            sunay = true
            addChild(sunayGoalField)
            
        } else if lastPaddleHit == sunayPaddle {
            riddhiGoalField = SKFieldNode.radialGravityField()
            riddhiGoalField.categoryBitMask = 8
            riddhiGoalField.region = SKRegion(size: CGSize(width: 200, height: 30))
            riddhiGoalField.position = CGPoint(x: 0, y: -self.frame.height/2)
            riddhiGoalField.strength = 10
            riddhi = true
            addChild(riddhiGoalField)
        }
        
        centerLine.run(SKAction.wait(forDuration: 7))
        
        if sunay {
            sunayGoalField.removeFromParent()
        } else if riddhi {
            riddhiGoalField.removeFromParent()
        }
        powerUpIsActive = false
    }
    
    func didCollideWithGoalProtectorPU() {
        var goalProtector = SKSpriteNode()
        
        if lastPaddleHit == riddhiPaddle {
            goalProtector.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 60), center: CGPoint(x: 0, y: -self.frame.height/2))
        } else if lastPaddleHit == sunayPaddle {
            goalProtector.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 60), center: CGPoint(x: 0, y: self.frame.height/2))
        }
        
        goalProtector.physicsBody?.isDynamic = false
        goalProtector.physicsBody?.allowsRotation = false
        goalProtector.physicsBody?.affectedByGravity = false
        goalProtector.physicsBody?.restitution = 1
        goalProtector.physicsBody?.friction = 0
        goalProtector.physicsBody?.categoryBitMask = 9
        goalProtector.physicsBody?.collisionBitMask = 2
        goalProtector.physicsBody?.fieldBitMask = 0
        goalProtector.physicsBody?.contactTestBitMask = 2
        goalProtector.physicsBody?.mass = 11
        
        addChild(goalProtector)
        
        centerLine.run(SKAction.wait(forDuration: 7))
        
        powerUpIsActive = false
        goalProtector.removeFromParent()
    }
    
    func didCollideWithFreezePU() {
        
        if lastPaddleHit == riddhiPaddle {
            sunayPaddle.fillColor = .blue
            sunayFrozenPaddle = true
        } else if lastPaddleHit == sunayPaddle {
            riddhiPaddle.fillColor = .blue
            riddhiFrozenPaddle = true
        }
        
        centerLine.run(SKAction.wait(forDuration: 7))
        
        sunayFrozenPaddle = false
        riddhiFrozenPaddle = false
        sunayPaddle.fillColor = .white
        riddhiPaddle.fillColor = .white
        powerUpIsActive = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if sunayFrozenPaddle == false {
            sunayPaddle.run(SKAction.moveTo(x: sunayBall.position.x, duration: 0.7))
        }
    }
    
    
    func projectileDidCollideWithGoal(puck: SKShapeNode, goal: SKSpriteNode) {
        print("entered projectileDidCollideWith")
        puck.removeFromParent()
        if (goal.position.y < 0) {
            addScore(winner: sunayPaddle)
        } else {
            addScore(winner: riddhiPaddle)
        }
        
        puck.removeFromParent()
        reset()
        
        if score[0] ==  1 {
            let gameOverTransition = SKTransition.flipVertical(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: gameOverTransition)
            gameOverScene.setWinnerText(text: "Player 1 wins!")
        } else if score[1] == 1 {
            let gameOverTransition = SKTransition.flipVertical(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: gameOverTransition)
            gameOverScene.setWinnerText(text: "Player 2 wins")
        }
        let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
        
        //let gameOverScene = GameOverScene(size: self.size, won: true)
        //view?.presentScene(gameOverScene, transition: reveal)
    }
    
    func reset() {
        sunayBall.position.x = 0
        sunayBall.position.y = 0
        
        riddhiPaddle.position.x = 0
        riddhiPaddle.position.y = -550
        
        sunayPaddle.position.x = 0
        sunayPaddle.position.y = 550
        
        sunayBall.run(SKAction.wait(forDuration: 1.0))
        addChild(sunayBall)
        sunayBall.run(SKAction.wait(forDuration: 1.0))
        
        sunayBall.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        //choosePowerUp()
        //displayPowerUp()
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // puck goes in the goal
        var puckBody: SKPhysicsBody = SKPhysicsBody()
        var goalBody: SKPhysicsBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 3 {
            puckBody = contact.bodyA
            goalBody = contact.bodyB
        } else if contact.bodyB.categoryBitMask == 2 && contact.bodyA.categoryBitMask == 3 {
            puckBody = contact.bodyB
            goalBody = contact.bodyA
        }
        
        if let puckB = puckBody.node as? SKShapeNode, let goalB = goalBody.node as? SKSpriteNode {
            projectileDidCollideWithGoal(puck: puckB, goal: goalB)
            return
        }
        
        // determining last paddle touched
        var paddleBody: SKPhysicsBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            paddleBody = contact.bodyA
            puckBody = contact.bodyB
        } else if contact.bodyB.categoryBitMask == 1 && contact.bodyA.categoryBitMask == 2 {
            paddleBody = contact.bodyB
            puckBody = contact.bodyA
        }
        
        if let paddleB = paddleBody.node as? SKShapeNode, let puckB = puckBody.node as? SKShapeNode {
            let forceVector = CGVector(dx: (riddhiPaddle.position.x - riddhiPaddleLastLocation.x) / 70, dy: (riddhiPaddle.position.y - riddhiPaddleLastLocation.y) / 70)
            puckB.physicsBody?.applyImpulse(forceVector, at: CGPoint(x: puckB.position.x, y: puckB.position.y))
            lastPaddleHit = paddleB
            return
        }
        
        // puck contacts power-up
        var powerUpBody: SKPhysicsBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 7 {
            puckBody = contact.bodyA
            powerUpBody = contact.bodyB
        } else if contact.bodyB.categoryBitMask == 2 && contact.bodyA.categoryBitMask == 7 {
            puckBody = contact.bodyB
            powerUpBody = contact.bodyA
        }
        
        if let puckB = puckBody.node as? SKShapeNode, let powerUpB = powerUpBody.node as? SKSpriteNode {
            
            currentPowerUp.removeFromParent()
            callCollideFunction(powerUpNum: randomPowerUpNum)
        }
    }
}
