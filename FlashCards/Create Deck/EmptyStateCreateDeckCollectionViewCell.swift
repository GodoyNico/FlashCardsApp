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
        self.emptyStateLabel.text = "Adicione cards  com perguntas e respostas e comece praticar!"
    }

}
