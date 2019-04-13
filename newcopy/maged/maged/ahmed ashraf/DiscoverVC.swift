//  ViewController.swift
//  SwipeTest
//  Created by MOAMEN on 12/24/1397 AP.
//  Copyright © 1397 maged. All rights reserved.

import UIKit

class DiscoverVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellId = "DiscoverCell"
    let imageArray = [UIImage(named: "slid1"), UIImage(named: "slid2"), UIImage(named: "slid3")]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiscoverCell
        cell.slideImage.image = imageArray[indexPath.row]
        
        if indexPath.row == imageArray.count - 1 {
            cell.finishOutlet.isHidden = false
            cell.showDiscover = { [ weak self] in
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
                let nav = UINavigationController(rootViewController: mainViewController!)
                UserDefaults.standard.set(false, forKey:"Flag")
                self?.present(nav, animated: true, completion: nil)
           }
       }
        
        return cell
    }
}

