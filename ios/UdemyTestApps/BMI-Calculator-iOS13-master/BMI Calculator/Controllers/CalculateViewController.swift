//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    var bmiValue: Float = 0.0
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bmiValue = bmiValue
        }
    }
    
    @IBAction func heightChanged(_ sender: UISlider) {
        let height = String(format: "%.1f", sender.value)
        heightValue.text = "\(height)m"
    }
    
    @IBAction func weightChanged(_ sender: UISlider) {
        let weight = sender.value
        weightValue.text = String(Int(weight))
    }
    
    
    @IBAction func calculate(_ sender: UIButton) {
        let weight = weightSlider.value
        let height = heightSlider.value
        bmiValue = weight / pow(height, 2)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
}

