//
//  NewCardTableViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

class NewCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var addCardButton: UIButton!
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    //let collectionCellID = "cardCollectionCell"
    
    @IBOutlet weak var deckImage: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                
    }

}
