//
//  GameCell.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    @IBOutlet weak var firstImage:  UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage:  UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    
    func setData(imagesArray: [GiftsTypes], shouldPrintSelf: Bool = false) {
        firstImage.image  = imagesArray[0].getImage()
        secondImage.image = imagesArray[1].getImage()
        thirdImage.image  = imagesArray[2].getImage()
        fourthImage.image = imagesArray[3].getImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.isHidden = false
        
        firstImage.isHidden  = false
        secondImage.isHidden = false
        thirdImage.isHidden  = false
        fourthImage.isHidden = false
    }
    
}
