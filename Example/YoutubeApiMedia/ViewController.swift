//
//  ViewController.swift
//  YoutubeApiMedia
//
//  Created by Maro90 on 12/05/2017.
//  Copyright (c) 2017 Maro90. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var manager = ViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.loadData().then { _ in
            self.collectionView.reloadData()
            }.catch { error in
                print("ERROR: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let YTController = segue.destination as? YTPlayerViewController {
            if let item = sender as? YoutubeCoverVideo {
                YTController.params = item
            }
        }
        
        if let YTController = segue.destination as? NativePlayerViewController {
            if let item = sender as? YoutubeCoverVideo {
                YTController.params = item
            }
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.idsYoutube.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "coverMediaCell", for: indexPath
            ) as! CoverMediaCollectionViewCell
        
        cell.loadData(item: self.manager.idsYoutube[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: ((collectionView.frame.width * 280) / 375)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select \(self.manager.idsYoutube[indexPath.row].id)")
        
        let alert = UIAlertController(
            title: "Api Youtube",
            message: "what media player do you want to use",
            preferredStyle: UIAlertControllerStyle.alert
        )

        alert.addAction(
            UIAlertAction(title: "Youtube", style: .default, handler: { action in
                self.performSegue(
                    withIdentifier: "playerYoutube",
                    sender: self.manager.idsYoutube[indexPath.row]
                )
            })
        )
        
        alert.addAction(
            UIAlertAction(title: "Native", style: .default, handler: { action in
                self.performSegue(
                    withIdentifier: "playerNative",
                    sender: self.manager.idsYoutube[indexPath.row]
                )
            })
        )
        
        self.present(alert, animated: true, completion: nil)
    }
}
