//
//  InteractiveView.swift
//  GiftsGame
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class InteractiveView: UIView {
    
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var colorImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorImageViewBottomConstraint: NSLayoutConstraint!
    
    private let cacheService = CacheService()
    var imagePosition: Int = 0
    
    func setImage(imagesArray: [GiftsTypes]) {
        self.colorImageView.image = imagesArray[1].getImage()
    }
    
    @objc func moveColorImageToTheRight() {
        if imagePosition < 3 {
            let margin = self.frame.width / 4
            
            UIView.animate(withDuration: 1.0,
                                  delay: 0.0,
                 usingSpringWithDamping: 1.0,
                  initialSpringVelocity: 10.0,
                                options: .curveEaseIn,
                             animations: { self.colorImageLeadingConstraint.constant += margin
                                           self.layoutIfNeeded() },
                             completion: nil)
            imagePosition += 1
        }
    }
    
    @objc func moveColorImageToTheLeft() {
        if imagePosition > 0 {
            let margin = self.frame.width / 4
            
            UIView.animate(withDuration: 1.0,
                                  delay: 0.0,
                 usingSpringWithDamping: 1.0,
                  initialSpringVelocity: 10.0,
                                options: .curveEaseIn,
                             animations: { self.colorImageLeadingConstraint.constant -= margin
                                           self.layoutIfNeeded() },
                             completion: nil)
            imagePosition -= 1
        }
    }
    
}
