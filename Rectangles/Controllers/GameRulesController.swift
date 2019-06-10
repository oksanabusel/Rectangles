//
//  GameRulesController.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class GameRulesController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
