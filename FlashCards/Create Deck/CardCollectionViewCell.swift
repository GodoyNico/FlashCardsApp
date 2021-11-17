//
//  cardCollectionViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

protocol AddCardImageDelegate: AnyObject {
    
    func selectImage(completion: @escaping (UIImage?) -> Void )
    
}

class CardCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //@IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var frontSideTextField: UITextView!
    @IBOutlet weak var backSideTextField: UITextView!
    @IBOutlet weak var numberOfCharacterBack: UILabel!
    @IBOutlet weak var numberOfCharactersFront: UILabel!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var sideALabel: UILabel!
    @IBOutlet weak var sideBLabel: UILabel!
    @IBOutlet weak var sideACounter: UILabel!
    @IBOutlet weak var sideBCounter: UILabel!
    
    weak var delegate: AddCardImageDelegate?
    var card: Card?
    
    @IBAction func addImageFront(_ sender: Any) {
        self.delegate?.selectImage { image in
            self.frontImage.image = image
            self.card?.front_content?.image = image?.pngData()
        }
    }
    
    @IBAction func addImageBack(_ sender: Any) {
        self.delegate?.selectImage { image in
            self.backImage.image = image
            self.card?.back_content?.image = image?.pngData()
        }
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
        
        sideALabel.text = NSLocalizedString("side_a", comment: "")
        sideBLabel.text = NSLocalizedString("side_b", comment: "")
        sideACounter.text = NSLocalizedString("max_characters", comment: "")
        sideBCounter.text = NSLocalizedString("max_characters", comment: "")
        
        frontImage.image = card.front_content?.image.flatMap(UIImage.init(data: ))
        backImage.image = card.back_content?.image.flatMap(UIImage.init(data: ))
        
        frontSideTextField.delegate = self
        backSideTextField.delegate = self
                
    }
}
