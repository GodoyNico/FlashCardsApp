//
//  cardCollectionViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

class cardCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    func textViewDidChange(_ textView: UITextView) {
        
        self.card?.front_content?.text = frontSideTextField.text
        self.card?.back_content?.text = backSideTextField.text

    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(card: Card) {
        self.card = card
        
        frontSideTextField.text = card.front_content?.text
        backSideTextField.text = card.back_content?.text
        
        frontSideTextField.delegate = self
        backSideTextField.delegate = self
        
    }
}
