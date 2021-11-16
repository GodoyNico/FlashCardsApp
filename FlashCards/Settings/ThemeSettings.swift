//  Created by Keith Harrison https://useyourloaf.com
//  Copyright © 2020 Keith Harrison. All rights reserved.
//
//  ThemeSettings.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 16/11/21.
//

import Foundation
import UIKit

enum Theme: Int {
    case dark
    case light
    case device
}

extension Theme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

extension UserDefaults {
    var theme: Theme {
        get {
            register(defaults: [#function: Theme.device.rawValue])
            return Theme(rawValue: integer(forKey: #function)) ?? .device
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
