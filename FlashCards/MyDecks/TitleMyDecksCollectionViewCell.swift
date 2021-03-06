//
//  TitleMyDecksCollectionViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 26/10/21.
//

import UIKit

class TitleMyDecksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myDecksTitleLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        myDecksTitleLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)
        
        myDecksTitleLabel.text = NSLocalizedString("my_decks", comment: "")
    }
}
