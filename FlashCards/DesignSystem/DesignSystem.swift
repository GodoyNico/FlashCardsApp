//
//  DesignSystem.swift
//  FlashCards
//
//  Created by Nicolas Godoy on 09/11/21.
//

import Foundation
import UIKit

public enum DesignSystem {
    // MARK: - Color
    public enum AssetsColor: String {
        case background
        case basicQuaternary
        case basicQuaternary2
        case basicQuinary
        case basicSecondary
        case basicTertiary
        case button
        case color1Primary
        case color1Secondary
        case color2Primary
        case color2Quaternary
        case color2Secondary
        case color2Tertiary
        case graySecondary
        case tabBar
        case tabBarTint
    }
}

public extension UIColor {
    convenience init?(designSystem: DesignSystem.AssetsColor) {
        self.init(named: designSystem.rawValue)
    }
}

//public extension CGColor {
//    convenience init?(designSystem: DesignSystem.AssetsColor) {
//        self.init(named: designSystem.rawValue)
//    }
//}
