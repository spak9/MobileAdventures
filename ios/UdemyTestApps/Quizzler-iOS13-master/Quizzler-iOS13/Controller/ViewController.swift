//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    var quizBrain = QuizBrain()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let wasCorrect = quizBrain.checkAnswer(userAnswer: userAnswer)
        quizBrain.questionIndex += 1
        updateUI()
    }
    
    func updateUI() {
        questionLabel.text = quizBrain.getCurrentQuestion().q
        progressBarView.progress = quizBrain.getCurrentProgress()
    }
}

