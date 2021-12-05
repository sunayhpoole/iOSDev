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
    
    var winner = SKLabelNode(text: "")
    
    override func didMove(to view: SKView) {
        
        let lightBlueColor = UIColor(displayP3Red: 230.0 / 255, green: 255.0 / 255, blue: 253.0 / 255, alpha: 1)
        
        view.backgroundColor = lightBlueColor
        
        winner.position = CGPoint(x: 450, y: 600)
        
        addChild(winner)
        
    }
    
    func setWinnerText(text: String) {
        winner.text = text
        winner.fontColor = .white
        winner.fontName = "MarkerFelt-Wide"
        winner.fontSize = 100
    }
    
}
