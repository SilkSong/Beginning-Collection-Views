//
//  ParkCell.swift
//  ParksPicker
//
//  Created by Song Zixin on 7/18/17.
//  Copyright © 2017 Razeware, LLC. All rights reserved.
//

import UIKit

class ParkCell: UICollectionViewCell {
    
    @IBOutlet weak var parkImageView: UIImageView!
    override func prepareForReuse() {
        parkImageView.image = nil
    }
    
    var park: Park? {
        didSet {
            if let nationalPark = park {
                parkImageView.image = UIImage(named: nationalPark.photo)
            }
        }
    }
    
}
