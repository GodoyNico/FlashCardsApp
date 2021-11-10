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
        case basicQuinary
        case basicSecondary
        case basicTertiary
        case color1Primary
        case color1Secondary
        case color2Primary
        case color2Quaternary
        case color2Secondary
        case color2Tertiary
        case graySecondary
    }
}

public extension UIColor {
    convenience init?(designSystem: DesignSystem.AssetsColor) {
        self.init(named: designSystem.rawValue)
    }
}
