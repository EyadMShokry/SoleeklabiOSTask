//
//  LittersViewController.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/27/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import UIKit

class LittersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var countriesNames = [String]()
    var capitalsNames = [String]()

    
    let littersArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P","Q", "R", "S", "T", "U", "W", "X", "Y", "Z"]
    @IBOutlet weak var littersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        littersCollectionView.dataSource = self
        littersCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return littersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let litterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "litterCell", for: indexPath) as! LitterCollectionViewCell
        litterCell.litterLabel.text = littersArray[indexPath.row]
        
        return litterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomePage") as! HomePageViewController
        homeViewController.letter = littersArray[indexPath.item]
        self.present(homeViewController, animated: true, completion: nil)

        
    }


}
