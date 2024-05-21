//
//  ViewController.swift
//  LayoutTesting
//
//  Created by stevenpak on 10/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addOne(_ sender: UIButton) {
        let value = Int(counter.text ?? "0")! + 1
        counter.text = String(value)
    }
}

