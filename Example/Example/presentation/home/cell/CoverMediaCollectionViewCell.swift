//
//  CoverMediaCollectionViewCell.swift
//  YoutubeMediaApi_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Kingfisher

class CoverMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    func loadData(item:YoutubeCoverVideo) {
        self.image.kf.setImage(with:
            URL(string:"https://img.youtube.com/vi/\(item.id)/maxresdefault.jpg")
        )
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        
        self.title.text = item.title
        self.descriptionLabel.text = item.channelTitle
    }
}
