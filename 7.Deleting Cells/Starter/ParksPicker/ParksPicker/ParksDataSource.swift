//
//  ParksDataSource.swift
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

class ParksDataSource {
  fileprivate var parks: [Park] = []
  fileprivate var immutableParks: [Park] = []
  fileprivate var sections: [String] = []
  
  var count: Int {
    return parks.count
  }
  
  var numberOfSections: Int {
    return sections.count
  }
  
  // MARK: - Public
  
  init() {
    parks = loadParksFromDisk()
    immutableParks = parks
  }
  
  func deleteItemsAtIndexPaths(_ indexPaths: [IndexPath]) {
    var indexes: [Int] = []
    for indexPath in indexPaths {
      indexes.append(absoluteIndexForIndexPath(indexPath))
    }
    var newParks: [Park] = []
    for (index, park) in parks.enumerated() {
      if !indexes.contains(index) {
        newParks.append(park)
      }
    }
    parks = newParks
  }
  
  func moveParkAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
    if indexPath == newIndexPath {
      return
    }
    let index = absoluteIndexForIndexPath(indexPath)
    let nationalPark = parks[index]
    nationalPark.state = sections[(newIndexPath as NSIndexPath).section]
    let newIndex = absoluteIndexForIndexPath(newIndexPath)
    parks.remove(at: index)
    parks.insert(nationalPark, at: newIndex)
  }
  
  func indexPathForNewRandomPark() -> IndexPath {
    let index = Int(arc4random_uniform(UInt32(immutableParks.count)))
    let parkToCopy = immutableParks[index]
    let newPark = Park(copying: parkToCopy)
    parks.append(newPark)
    parks.sort { $0.index < $1.index }
    return indexPathForPark(newPark)
  }
  
  func indexPathForPark(_ park: Park) -> IndexPath {
    let section = sections.index(of: park.state)!
    var item = 0
    for (index, currentPark) in parksForSection(section).enumerated() {
      if currentPark === park {
        item = index
        break
      }
    }
    return IndexPath(item: item, section: section)
  }
  
  func numberOfParksInSection(_ index: Int) -> Int {
    let nationalParks = parksForSection(index)
    return nationalParks.count
  }
  
  func parkForItemAtIndexPath(_ indexPath: IndexPath) -> Park? {
    if (indexPath as NSIndexPath).section > 0 {
      let nationalParks = parksForSection((indexPath as NSIndexPath).section)
      return nationalParks[(indexPath as NSIndexPath).item]
    } else {
      return parks[(indexPath as NSIndexPath).item]
    }
  }
  
  func titleForSectionAtIndexPath(_ indexPath: IndexPath) -> String? {
    if (indexPath as NSIndexPath).section < sections.count {
      return sections[(indexPath as NSIndexPath).section]
    }
    return nil
  }
  
  
  // MARK: - Private
  
  fileprivate func loadParksFromDisk() -> [Park] {
    sections.removeAll(keepingCapacity: false)
    if let path = Bundle.main.path(forResource: "NationalParks", ofType: "plist") {
      if let dictArray = NSArray(contentsOfFile: path) {
        var nationalParks: [Park] = []
        for item in dictArray {
          if let dict = item as? NSDictionary {
            let name = dict["name"] as! String
            let state = dict["state"] as! String
            let date = dict["date"] as! String
            let photo = dict["photo"] as! String
            let index = dict["index"] as! Int
            let park = Park(name: name, state: state, date: date, photo: photo, index: index)
            if !sections.contains(state) {
              sections.append(state)
            }
            nationalParks.append(park)
          }
        }
        return nationalParks
      }
    }
    return []
  }
  
  fileprivate func absoluteIndexForIndexPath(_ indexPath: IndexPath) -> Int {
    var index = 0
    for i in 0..<(indexPath as NSIndexPath).section {
      index += numberOfParksInSection(i)
    }
    index += (indexPath as NSIndexPath).item
    return index
  }
  
  fileprivate func parksForSection(_ index: Int) -> [Park] {
    let section = sections[index]
    let parksInSection = parks.filter { (park: Park) -> Bool in
      return park.state == section
    }
    return parksInSection
  }
  
  
  
}

