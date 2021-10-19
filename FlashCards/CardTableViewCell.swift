//
//  CardTableViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 15/10/21.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var frontContentCell: UILabel!
    @IBOutlet weak var backContentCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
