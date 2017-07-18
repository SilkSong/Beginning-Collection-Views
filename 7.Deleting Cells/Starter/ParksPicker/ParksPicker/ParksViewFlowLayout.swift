//
//  ParksViewFlowLayout.swift
//  ParksPicker
/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 

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
