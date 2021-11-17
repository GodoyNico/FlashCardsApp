//
//  EmptyStateMyDecksCollectionViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 16/11/21.
//

import UIKit

class EmptyStateMyDecksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    var textLabel: String?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        self.emptyStateLabel.text = NSLocalizedString("empty_state_deck", comment: "")
    }
    
}
