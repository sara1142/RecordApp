//
//  PlaySoundsViewController.swift
//  RecordApp
//
//  Created by Muneef on 14/07/1440 AH.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var squirrelButton: UIButton!
    @IBOutlet weak var bunnyButton: UIButton!
    @IBOutlet weak var DarthButton: UIButton!
    @IBOutlet weak var birdButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case snail = 0, bunny, squirrel, Darth, bird, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .snail:
            playSound(rate: 0.5)
        case .bunny:
            playSound(rate: 1.5)
        case .squirrel:
            playSound(pitch: 1000)
        case .Darth:
            playSound(pitch: -1000)
        case .bird:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
    }
         configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setupAudio()
        stopButton.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    



}
