//
//  EmptyStateCreateDeckTableViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 16/11/21.
//

import UIKit

class EmptyStateCreateDeckCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emptyStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        self.emptyStateLabel.text = NSLocalizedString("empty_deck_message", comment: "")
    }

}
