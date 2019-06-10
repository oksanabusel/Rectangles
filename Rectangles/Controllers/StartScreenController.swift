//
//  StartScreenController.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class StartScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: isSwitcherOn) {
            SoundSettings.shared.startPlaying()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
