//
//  GameOverScene.swift
//  FlairHockey
//
//  Created by Riddhi Bagadiaa on 05/05/19.
//  Copyright © 2019 Planets. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    
    var gameOverText = SKLabelNode(text: "GAME OVER")
    var winner = SKLabelNode(text: "")
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let centreCircle = SKShapeNode(circleOfRadius: 90)
        centreCircle.glowWidth = 3.0
        centreCircle.strokeColor = .blue
        centreCircle.position.x = 0
        centreCircle.position.y = 0
        addChild(centreCircle)
        
        let goalBox = SKShapeNode(rectOf: CGSize(width: 600, height: 120))
        goalBox.position.x = 0
        goalBox.position.y = self.frame.height/2
        goalBox.glowWidth = 3.0
        goalBox.strokeColor = .blue
        addChild(goalBox)
        
        let goalBox1 = SKShapeNode(rectOf: CGSize(width: 600, height: 120))
        goalBox1.position.x = 0
        goalBox1.position.y = -self.frame.height/2
        goalBox1.glowWidth = 3.0
        goalBox1.strokeColor = .blue
        addChild(goalBox1)
        
        let centerLine = SKSpriteNode()
        centerLine.size.width = self.frame.width
        centerLine.size.height = 5
        centerLine.position.x = 0
        centerLine.position.y = 0
        
        centerLine.color = .black
        addChild(centerLine)
        
        let lightBlueColor = UIColor(displayP3Red: 230.0 / 255, green: 255.0 / 255, blue: 253.0 / 255, alpha: 1)
        
        self.backgroundColor = lightBlueColor
        
        gameOverText.fontColor = .red
        gameOverText.fontName = "MarkerFelt-Wide"
        gameOverText.fontSize = 125
        gameOverText.position = CGPoint(x: 0, y: 150)
        
        winner.position = CGPoint(x: 0, y: -200)
        
        addChild(gameOverText)
        addChild(winner)
        
    }
    
    func setWinnerText(text: String) {
        winner.text = text
        winner.fontColor = .red
        winner.fontName = "MarkerFelt-Wide"
        winner.fontSize = 95
    }
    
}
