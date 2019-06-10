//
//  SettingsViewController.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var switcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if UserDefaults.standard.bool(forKey: isSwitcherOn) {
            switcher.isOn = true
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func tapSwitcher(_ sender: UISwitch) {
        if switcher!.isOn {
            SoundSettings.shared.startPlaying()
            UserDefaults.standard.set(true, forKey: isSwitcherOn)
        } else {
            SoundSettings.shared.stopPlaying()
            UserDefaults.standard.set(false, forKey: isSwitcherOn)
        }
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
