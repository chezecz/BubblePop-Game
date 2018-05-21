//
//  Bubble.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 30/4/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class Bubble: NSObject {

    var radius: Int = 20
    var xBubble: Int = 0
    var yBubble: Int = 0
    var xCollision : Array<Int> = Array()
    var yCollision : Array<Int> = Array()
    var points: Int?
    var colour: String?
    
    init(xCollision : Array<Int>, yCollision : Array<Int>) {
        self.xCollision = xCollision
        self.yCollision = yCollision
        self.radius = Int(0.057 * Double(UIScreen.main.bounds.height))
    }
    
    func getRandomXCoordinates() -> Int {
        var xRandom : Int = 0
        while true {
            xRandom = Int(arc4random_uniform(UInt32(UIScreen.main.bounds.width)))
            if xRandom + self.radius < Int(UIScreen.main.bounds.width) && xRandom - self.radius > 0 {
                break
            }
        }
        return xRandom
    }
    
    func getRandomYCoordinates() -> Int {
        var yRandom : Int = 0
        let topHeight = 0.12 * Double(UIScreen.main.bounds.height)
        while true {
            yRandom = Int(topHeight) + Int(arc4random_uniform(UInt32(UIScreen.main.bounds.height) - UInt32(topHeight)))
            if yRandom + self.radius < Int(UIScreen.main.bounds.height) && yRandom - self.radius > 0 {
                break
            }
        }
        return yRandom
    }
    
    func checkCollisions(pointX: Int, pointY: Int) -> Bool {
        for i in 0..<xCollision.count {
            if abs(pointX - xCollision[i]) <= (2*self.radius) && abs(pointY - yCollision[i]) <= (2*self.radius){
                return false
            }
        }
        return true
    }
    
    func checkTouch(pointX: Int, pointY: Int) -> Bool {
            if abs(pointX - xBubble) <= self.radius && abs(pointY - yBubble) <= self.radius{
                return true
            }
        return false
    }
    
    func draw() -> CAShapeLayer{
        while true {
            xBubble = getRandomXCoordinates()
            yBubble = getRandomYCoordinates()
            if checkCollisions(pointX: xBubble, pointY: yBubble) {
                let circlePath = UIBezierPath(arcCenter: CGPoint(x: xBubble,y: yBubble), radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = circlePath.cgPath
                
                let randomNumber = arc4random_uniform(100)
                
                switch randomNumber {
                case 0..<40:
                    self.points = 1
                    self.colour = "red"
                    shapeLayer.fillColor = UIColor.red.cgColor
                case 40..<70:
                    self.points = 2
                    self.colour = "magenta"
                    shapeLayer.fillColor = UIColor.magenta.cgColor
                case 70..<85:
                    self.points = 5
                    self.colour = "green"
                    shapeLayer.fillColor = UIColor.green.cgColor
                case 85..<95:
                    self.points = 8
                    self.colour = "blue"
                    shapeLayer.fillColor = UIColor.blue.cgColor
                case 95..<100:
                    self.points = 10
                    self.colour = "black"
                    shapeLayer.fillColor = UIColor.black.cgColor
                default:
                    self.points = 0
                    self.colour = "clear"
                    shapeLayer.fillColor = UIColor.clear.cgColor
                }
                return shapeLayer
            }
        }
        
    }
    
    func colourMultiplier(colour: String) -> Int{
        if colour == self.colour {
            self.points = Int(1.5 * Double(self.points!))
        }
        return self.points!
    }
    
    func popped(previousColour: String) -> Int{
        let pointsGained = colourMultiplier(colour: previousColour)
        self.points = 0
        return pointsGained
    }
    
    func drawInvalid() -> CAShapeLayer {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: xBubble,y: yBubble), radius: CGFloat(radius+1), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineWidth = 0
        shapeLayer.fillColor = UIColor.white.cgColor
        return shapeLayer
    }
    
    
    func xCoordinatesReturn() -> Int {
        return xBubble
    }
    
    func yCoordinatesReturn() -> Int {
        return yBubble
    }
}
