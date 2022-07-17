//
//  ViewController.swift
//  Eggs
//
//  Created by Ержан Джанарстанов on 10.04.2022.
//

import UIKit
import AVFoundation

enum Constants {
    static let message: String = "How do you like your eggs?"
    static let doneMessage: String  = "Done"
    static let soundName: String = "alarm_sound"
    static let soundType: String = "mp3"
    
    
}


final class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var progressiv: UIProgressView!
    
    // MARK: - Private Properties
    
    private let eggSeconds:[String:Int] = ["Soft":5, "Medium": 7, "Hard": 12]
    private var timer: Timer?
    private var player: AVAudioPlayer?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
    // MARK: - Actions
    
    private extension ViewController {
    
    @IBAction private func tapButton(_ sender: UIButton) {
        guard let currentSeconds = eggSeconds[sender.currentTitle!] else {return}
        reset()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.updateProgress(with: currentSeconds)
        }
        
        
    }
    // MARK: - Private
        
    private func updateProgress(with currentSeconds: Int) {
        let result = 1.0 / Float(currentSeconds)
        progressiv.progress += result
        if progressiv.progress == 1 {
            timer?.invalidate()
            label.text = Constants.doneMessage
           playAlarm()
        }
    }
    
    private func playAlarm() {
        guard let path = Bundle.main.path(forResource:Constants.soundName, ofType:Constants.soundType ),
                 let url = URL(string: path) else {return}
         player = try? AVAudioPlayer(contentsOf:url)
         player?.play()
    }
    
    private func reset() {
        progressiv.progress = 0
        label.text = Constants.message
        timer?.invalidate()
    }
    
 
}
