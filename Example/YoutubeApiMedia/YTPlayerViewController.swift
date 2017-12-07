//
//  YTPlayerViewController.swift
//  YoutubeApiMedia_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YTPlayerViewController: UIViewController {
    @IBOutlet var player:YTPlayerView!
    var params:YoutubeCoverVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadVideo()
        // Do any additional setup after loading the view.
    }
    
    func loadVideo() {
        if let idVideo = self.params?.id {
           self.player.load(withVideoId: idVideo)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
