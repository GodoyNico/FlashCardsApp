//
//  DeckTableViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 15/10/21.
//

import UIKit

class DeckTableViewCell: UITableViewCell {

    @IBOutlet weak var titleDeckLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
