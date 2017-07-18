//
//  ParksViewFlowLayout.swift
//  ParksPicker
//
//  Created by Michael Briscoe on 11/14/16.
//  Copyright © 2016 Razeware, LLC. All rights reserved.
//

import UIKit

class ParksViewFlowLayout: UICollectionViewFlowLayout {

  var appearingIndexPath: IndexPath?
  
  override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    
    guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath), let indexPath = appearingIndexPath , indexPath == itemIndexPath else {
            
            return nil
    }
    
    attributes.alpha = 1.0
    attributes.center = CGPoint(x: collectionView!.frame.width - 23.5, y: -24.5)
    attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
    attributes.zIndex = 5
        
    return attributes
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var cache = [UICollectionViewLayoutAttributes]()
    if let layoutAttributes = super.layoutAttributesForElements(in: rect) {
      for attributes in layoutAttributes {
          let cellAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
        if attributes.representedElementKind == nil {
              let frame = cellAttributes.frame
          cellAttributes.frame = frame.insetBy(dx: 2.0, dy: 3.0)
        }
          cache.append(cellAttributes)
      }
    }
    return cache
  }
}
