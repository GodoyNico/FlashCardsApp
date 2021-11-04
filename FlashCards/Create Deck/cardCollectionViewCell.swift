//
//  cardCollectionViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

class cardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontSideTextField: UITextView!
    @IBOutlet weak var backSideTextField: UITextView!
    @IBOutlet weak var numberOfCharacterBack: UILabel!
    @IBOutlet weak var numberOfCharactersFront: UILabel!
    
    var card: Card?
    
    @IBAction func addImageFront(_ sender: Any) {
        print("clicou1")
    }
    
    @IBAction func addImageBack(_ sender: Any) {
        print("clicou2")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configure(card: Card) {
        self.card = card
        
        frontSideTextField.text = card.front_content?.text
        backSideTextField.text = card.back_content?.text
    }
}
