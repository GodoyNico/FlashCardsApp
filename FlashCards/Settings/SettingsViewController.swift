//  Created by Keith Harrison https://useyourloaf.com
//  Copyright © 2020 Keith Harrison. All rights reserved.
//
//  SettingsViewController.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 16/11/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var themeSC: UISegmentedControl!
    @IBOutlet weak var creditsLabel: UILabel!
    
    private var theme: Theme {
        get {
            return defaults.theme
        }
        set {
            defaults.theme = newValue
            configureStyle(for: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeSC.selectedSegmentIndex = theme.rawValue
        creditsLabel.text = NSLocalizedString("credits", comment: "")
    }
    
    @IBAction func themeSegmentedControl(_ sender: UISegmentedControl) {
        theme = Theme(rawValue: sender.selectedSegmentIndex ) ?? .device
    }
    
    private func configureStyle(for theme: Theme) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
    
}
