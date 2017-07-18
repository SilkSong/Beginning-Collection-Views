//
//  MasterViewController.swift
//  ParksPicker
//
//  Created by Song Zixin on 7/18/17.
//  Copyright © 2017 Razeware, LLC. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
    
    fileprivate var parksDataSource = ParksDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail" {
            if let indexPath = collectionView!.indexPathsForSelectedItems!.first {
                if let park = parksDataSource.parkForItemAtIndexPath(indexPath) {
                    let detailViewController = segue.destination as! DetailViewController
                    detailViewController.park = park
                }
            }
        }
    }
}

extension MasterViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parksDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.textLabel!.text = "\(indexPath.row)"
        return cell
    }
    
    


}
