//
//  GameViewController.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 30/4/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var settings: Settings?
    var player: User?
    var timerSeconds = Timer()
    var timerGame = Timer()
    var timerBeforeStart = Timer()
    var seconds: Int?
    var refreshFrequency: Int?
    var previousNumber: Int?
    var bubblesArray: Array<Bubble> = Array()
    var previousColour: String = "clear"
    var beforeStartSeconds = 3
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var beforeStartLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        player?.points = 0
        seconds = settings?.time
        previousNumber = 0
        secondsLabel.text = String(seconds!)
        pointsLabel.text = String(player!.points)
        refreshFrequency = settings?.frequency
        beforeStartLabel.text = String(beforeStartSeconds)
        updateStartTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.beforeStartLabel.isHidden = true
            self.updateTimer()
            self.updateScreen()
        })
    }
    
    func updateStartTimer() {
        timerGame = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beforeStartGame), userInfo: nil, repeats: true)
    }
    @objc func beforeStartGame() {
        beforeStartLabel.text = String(beforeStartSeconds)
        beforeStartSeconds -= 1
    }
    func updateScreen() {
        drawBubbles()
        timerGame = Timer.scheduledTimer(timeInterval: TimeInterval(refreshFrequency!), target: self, selector: #selector(drawBubbles), userInfo: nil, repeats: true)
    }
    func updateTimer() {
        timerSeconds = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    @objc func updateTimerLabel() {
        seconds! -= 1
        secondsLabel.text = String(seconds!)
        if seconds == 0 {
            self.performSegue(withIdentifier: "toEndGame", sender: self)
        }
    }
    
    func deleteBubbles(numberBubbles: Int) {
        if numberBubbles != 0 {
            for _ in 0..<numberBubbles {
                let _ = view.layer.sublayers?.popLast()
            }
        }
    }

    
    @objc func drawBubbles() {
        deleteBubbles(numberBubbles: previousNumber!)
        bubblesArray = []
        var xCoordinates : Array<Int> = Array()
        var yCoordinates : Array<Int> = Array()
        let maxBubbles : Int = (settings?.maxNumber)!
        let currentBubbles : Int = Int(arc4random_uniform(UInt32(maxBubbles)))+1
        previousNumber = currentBubbles
        for _ in 1...currentBubbles {
            let BubblePop = Bubble(xCollision: xCoordinates, yCollision: yCoordinates)
            self.view.layer.addSublayer(BubblePop.draw())
            xCoordinates.append(BubblePop.xCoordinatesReturn())
            yCoordinates.append(BubblePop.yCoordinatesReturn())
            bubblesArray.append(BubblePop)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.view)
            for bubble in bubblesArray {
                if bubble.checkTouch(pointX: Int(position.x), pointY: Int(position.y)) {
                    player?.points += bubble.popped(previousColour: previousColour)
                    self.view.layer.addSublayer(bubble.drawInvalid())
                    previousNumber! += 1
                    pointsLabel.text = String(player!.points)
                    previousColour = bubble.colour!
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passSettings = segue.destination as? GameOverViewController{
            passSettings.player = self.player
            passSettings.settings = self.settings
        }
    }
}
