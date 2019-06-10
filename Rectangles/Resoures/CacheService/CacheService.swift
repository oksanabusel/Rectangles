//
//  CacheService.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

typealias ColorsRow = [GiftsTypes]

enum GiftsTypes {
  case red
  case green
  case violet
  case yellow
  
  func getImage() -> UIImage {
    switch self {
    case .red:
      let result: UIImage = #imageLiteral(resourceName: "red")
      return result
    case .green:
      let result: UIImage = #imageLiteral(resourceName: "green")
      return result
    case .yellow:
      let result: UIImage = #imageLiteral(resourceName: "yellow")
      return result
    case .violet:
      let result: UIImage = #imageLiteral(resourceName: "violet")
      return result
    }
  }
}

class CacheService {
  var imagesRowArray: [GiftsTypes] = []
  var sourceArray:    [[GiftsTypes]] = []
  
  private var index: Int = 0
  private var previousImagesRow: [GiftsTypes] = []
  
  func fillDataSourceArray(completion: () -> Void) {
    let red    = GiftsTypes.red
    let green  = GiftsTypes.green
    let yellow = GiftsTypes.yellow
    let violet = GiftsTypes.violet
    
    imagesRowArray.append(red)
    imagesRowArray.append(green)
    imagesRowArray.append(yellow)
    imagesRowArray.append(violet)
  
    for i in 0...3000 {
      imagesRowArray.shuffle()
      
      if i == 0 {
        sourceArray.append(imagesRowArray)
      }
      previousImagesRow = sourceArray[index]
      index += 1
      let result = swapIdenticalValues(first: imagesRowArray, second: previousImagesRow)
      sourceArray.append(result)
    }    
    completion()
  }
  
  func swapIdenticalValues(first: [GiftsTypes], second: [GiftsTypes]) -> [GiftsTypes] {
    var result = first
    let random = Bool.random()
    
    if random == true {
      if result[0] == second[0] {
        result.swapAt(0, 1)
      }
      if result[1] == second[1] {
        result.swapAt(1, 2)
      }
      if result[2] == second[2] {
        result.swapAt(2, 3)
      }
    } else {
      if result[2] == second[2] {
        result.swapAt(2, 3)
      }
      if result[3] == second[3] {
        result.swapAt(2, 3)
      }
    }
    return result
  }
  
}
