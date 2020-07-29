//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Ranajit Chandra on 28/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var songPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func prepaseSongAndSession() {
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!))
        } catch {
            print(error)
        }
    }

    @IBAction func playButton(_ sender: UIButton) {
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
    }
    
    @IBAction func restartButton(_ sender: Any) {
    }
    
}

