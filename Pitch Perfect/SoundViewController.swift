//
//  SoundViewController.swift
//  Pitch Perfect
//
//  Created by Vigneshraj Sekar Babu on 8/9/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    var recordedAudioURL : URL!
    
    @IBOutlet weak var slowButton : UIButton!
    @IBOutlet weak var fastButton : UIButton!
    @IBOutlet weak var lowPitchButton : UIButton!
    @IBOutlet weak var hightPitchButton : UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var reverbButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, vader, chipmunk, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //print(recordedAudioURL.absoluteString)
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    
    //MARK: - Playback Control
    
    @IBAction func stopButtonPressed(_ sender: UIButton){
        stopAudio()
    }

    @IBAction func playSoundForButton(_ sender: AnyObject) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .vader:
            playSound(pitch: -1000)
        case .chipmunk:
            playSound(pitch: 1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    //MARK: - ConfigureUI
    
    func configureUI() {
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        hightPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit

        
    }
    
}
