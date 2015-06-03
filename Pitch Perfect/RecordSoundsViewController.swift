//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Idris Jafer on 6/1/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingInProgress: UILabel!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        stopButton.hidden=true;
        recordButton.enabled=true
        recordingInProgress.text="Tap to Record"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        recordButton.enabled=false
        stopButton.hidden=false;
       // recordingInProgress.hidden=false;
        recordingInProgress.text="Recording in progress ... "
        
        //TODO: Record the audio
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
       // audioRecorder.prepareToRecord()
        audioRecorder.record()
        
       // println("record audio")
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
       // recordingInProgress.hidden = true
        stopButton.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
        //TODO: save the recorded audio
        recordedAudio=RecordedAudio(path: recorder.url,title: recorder.url.lastPathComponent!)
//        recordedAudio.filePathUrl=recorder.url
//        recordedAudio.title=recorder.url.lastPathComponent
        
        //TODO: Move to next segue
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            println("Recording was not successful")
            recordButton.enabled=true;
            stopButton.hidden=true;
        }
    }

   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="stopRecording")
        {
            let playSoundsVC:PlaySoundsViewController=segue.destinationViewController as! PlaySoundsViewController
            
            let data=sender as! RecordedAudio
            
            playSoundsVC.receivedAudio=data
            
        }
    }
}

