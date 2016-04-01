//
//  ViewController.swift
//  SuperCool
//
//  Created by Yi Ju Chen on 3/30/16.
//  Copyright © 2016 YJC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var doomLogo: UIImageView!
    @IBOutlet weak var happyBG: UIImageView!
    @IBOutlet weak var doomInitializer: UIButton!
    @IBOutlet weak var doomFace: UIImageView!
    var mode = 1
    
    var musicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Mellowtron", ofType: "mp3")!)
    
    var screamURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("scream", ofType: "mp3")!)
    
    var musicPlayer = AVAudioPlayer()
    
    var screamPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupScream()
        setupMusic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doomActivation(sender: AnyObject) {
        if(mode == 1) {
            musicPlayer.stop()
            doomLogo.hidden = true
            happyBG.hidden = true
            doomFace.hidden = false
            doomInitializer.enabled = false
            mode = 2
            screamPlayer.currentTime = 0
            screamPlayer.play()
            delay(2) {
                self.doomInitializer.setTitle("Salvation", forState: .Normal)
                self.doomInitializer.enabled = true
            }
        } else {
            doomLogo.hidden = false
            happyBG.hidden = false
            doomFace.hidden = true
            doomInitializer.setTitle("Doom", forState: .Normal)
            mode = 1
            screamPlayer.stop()
            musicPlayer.play()
        }
    }
    
    func setupScream() {
        do {
            screamPlayer = try AVAudioPlayer(contentsOfURL: screamURL, fileTypeHint: AVFileTypeMPEGLayer3)
            screamPlayer.volume = 10
            screamPlayer.prepareToPlay()
        } catch {
            print("cannot play file")
        }
        
    }
    
    func setupMusic() {
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: musicURL, fileTypeHint: AVFileTypeMPEGLayer3)
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.5
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch {
            print("cannot play file")
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

