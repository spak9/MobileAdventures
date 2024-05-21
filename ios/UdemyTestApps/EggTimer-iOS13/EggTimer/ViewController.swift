//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBarView.progress = 0.0
        secondsPassed = 0
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        print("User clicked on \(hardness)")
        
        // Callback on timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        progressBarView.progress = Float(secondsPassed) / Float(totalTime)
        if secondsPassed < totalTime {
            print("\(totalTime - secondsPassed) seconds left.")
            secondsPassed += 1
        }
        else {
            print("All done!")
            titleLabel.text = "Done!"
            timer.invalidate()
        }
    }
    

}
