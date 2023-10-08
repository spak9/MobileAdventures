//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "C", withExtension: "wav")
        let player = try! AVAudioPlayer(contentsOf: url!)
        print(player)
        player.play()
//        guard let url = Bundle.main.url(forResource: "C", withExtension: ".wav") else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            print(1)
//            try AVAudioSession.sharedInstance().setActive(true)
//            print("adsf")
//
//            let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            player.play()
//
//        } catch let error {
//            print(error)
//        }
    }


    @IBAction func keyCPressed(_ sender: UIButton) {
        print("C")
        playSound()
    }
    
    @IBAction func keyDPressed(_ sender: Any) {
        print("'D' Pressed")
    }
    
}

