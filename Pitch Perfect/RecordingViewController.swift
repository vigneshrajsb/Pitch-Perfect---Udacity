//
//  RecordingViewController.swift
//  Pitch Perfect
//
//  Created by Vigneshraj Sekar Babu on 8/8/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController, AVAudioRecorderDelegate {
    let segueStopRecord = "stopRecording"

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder : AVAudioRecorder!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
    }

 
    //MARK: - Playback control
    
    @IBAction func recordPressed(_ sender: UIButton) {
        configureUIFor(recordingFlag: true)
        let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let fileName = "recording.wav"
        let pathArray = [directory, fileName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        configureUIFor(recordingFlag: false)
        stopRecording()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    //MARK: - AVAudioRecorderDelegate methods
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        performSegue(withIdentifier: segueStopRecord, sender: audioRecorder.url)
        } else {
            let alert = UIAlertController(title: "Error", message: "Recording Failed!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                self.stopRecording()
                self.configureUIFor(recordingFlag: false)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueStopRecord {
            if let destinationVC = segue.destination as? SoundViewController {
                destinationVC.recordedAudioURL = sender as? URL
            }
        }
    }
    
    func configureUIFor(recordingFlag: Bool) {
        recordingLabel.text = recordingFlag ? "Recording" : "Recording Stopped"
        stopButton.isEnabled = recordingFlag
        recordButton.isEnabled = !recordingFlag
    }
}

