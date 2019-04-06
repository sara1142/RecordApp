//
//  RecordSoundsViewController.swift
//  RecordApp
//
//  Created by Muneef on 11/07/1440 AH.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var RecordingLabel: UILabel!
    @IBOutlet weak var StopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StopRecordingButton.isEnabled = false
        
    }
    
  
    
    func configUI(isRecording: Bool) {
        if isRecording == true {
            RecordButton.isEnabled = true
            StopRecordingButton.isEnabled = false
            RecordingLabel.text = "Tap to Record"
        } else {
            RecordingLabel.text  = "Recording in Progress"
            StopRecordingButton.isEnabled = true
            RecordButton.isEnabled = false
        }
    }
    
    
    @IBAction func RecordAudio(_ sender: AnyObject) {

         configUI(isRecording: false)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }
    
    @IBAction func StopRecording(_ sender: Any) {

        configUI(isRecording: true)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }

    
 
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            self.performSegue(withIdentifier: "StopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not Successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "StopRecording" else { return }
        guard let playSoundsVC = segue.destination as? PlaySoundsViewController else { return }
        guard let recordedAudioURL = sender as? URL else { return }
        playSoundsVC.recordedAudioURL = recordedAudioURL
    

        }
    }
    


