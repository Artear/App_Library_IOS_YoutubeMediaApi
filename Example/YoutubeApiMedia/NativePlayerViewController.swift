//
//  NativePlayerViewController.swift
//  YoutubeApiMedia_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MediaPlayer
import YoutubeApiMedia

class NativePlayerViewController: UIViewController {
    @IBOutlet var player:UIView!
    var params:YoutubeCoverVideo?
    
    var avPlayer:AVPlayer?
    var avPlayerLayer:AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadVideo()
        // Do any additional setup after loading the view.
    }

    func loadVideo() {
        guard let youtubeID = self.params?.id else {
            return
        }
        
        YoutubeMediaApi(id: youtubeID).run().then{ metadata -> Void in
			let media = metadata.getMedia()
			
			let source = media?.getSources()[0]
			guard let URLString = source?.getURL() else{
				return
			}
			
			let videoURL = URL(string: URLString)
            self.avPlayer = AVPlayer(url: videoURL!)
            self.avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
            self.avPlayerLayer?.backgroundColor = UIColor.black.cgColor
            self.avPlayerLayer?.frame = self.player.bounds
            self.player.layer.addSublayer(self.avPlayerLayer!)
            self.avPlayer?.play()
            }.catch { error in
                print("Error load video \(error.localizedDescription)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.avPlayerLayer?.frame = self.player.bounds
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
