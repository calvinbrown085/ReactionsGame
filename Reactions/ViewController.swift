//
//  ViewController.swift
//  Reactions
//
//  Created by Calvin Brown on 2/17/17.
//  Copyright © 2017 Calvin Brown. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var lContainer: UIButton!
    @IBOutlet var rightContainer: UIButton!
    var hitCount: Int = 0
    var timeCount: Int = 0
    var hardnessInterval: Double = 1
    var whereIsContainer: Int = 0 //0 is left container, 1 is right container.
    var containerTimer = Timer()
    var hardnessTimer = Timer()
    
  
    @IBAction func button1TouchDown(_ sender: UIButton) {
        if whereIsContainer == 1 {
            gameOver()        }
        else {
            sender.backgroundColor = UIColor.white
            hitCount += 1
            scoreLabel.text = String(hitCount)
            lContainer.backgroundColor = UIColor.darkGray
        }

    }
    @IBAction func button2TouchDown(_ sender: UIButton) {
        if whereIsContainer == 0 {
            gameOver()        }
        else {
            sender.backgroundColor = UIColor.white
            hitCount += 1
            scoreLabel.text = String(hitCount)
            rightContainer.backgroundColor = UIColor.darkGray
        }

    }
  
    
    
    @IBAction func touchButton1(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.black
        }
    }
    @IBAction func touchButton2(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.black
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(hitCount)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackToBlack(button: UIButton) {
        button.backgroundColor = UIColor.black
    }
    @IBAction func resetButtons(_ sender: UIButton) {
        hitCount = 0
        timeCount = 0
        scoreLabel.text = String(hitCount)
        lContainer.backgroundColor = UIColor.darkGray
        rightContainer.backgroundColor = UIColor.darkGray
        containerTimer.invalidate()
        hardnessTimer.invalidate()
    }
    @IBAction func startGame(_ sender: UIButton) {
        containerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleContainer), userInfo: nil, repeats: true)
        hardnessTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHardenedCount), userInfo: nil, repeats: true)
        hitCount = 0
        scoreLabel.text = String(hitCount)
        lContainer.backgroundColor = UIColor.darkGray
        rightContainer.backgroundColor = UIColor.darkGray
    }
    
    func handleContainer() {
        let random = Int(arc4random_uniform(2))
        if random == 1 {
            whereIsContainer = 1
            rightContainer.backgroundColor = UIColor.white
        }
        else {
            whereIsContainer = 0
            lContainer.backgroundColor = UIColor.white
        }
    }
    
    func timerHardenedCount() {
        print(timeCount)
        if timeCount % 20 == 0 {
            print("Increasing difficulty")
            containerTimer.invalidate()
            hardnessInterval -= 0.1
            containerTimer = Timer.scheduledTimer(timeInterval: hardnessInterval, target: self, selector: #selector(handleContainer), userInfo: nil, repeats: true)
        }
        timeCount += 1
    }
    
    func gameOver() {
        containerTimer.invalidate()
        hardnessTimer.invalidate()
        timeCount = 0
        scoreLabel.text = "Game Over! You had \(hitCount) points!"
    }
    
    
}


