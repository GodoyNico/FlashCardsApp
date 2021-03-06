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
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var frontSideTextField: UITextView!
    @IBOutlet weak var backSideTextField: UITextView!
    @IBOutlet weak var numberOfCharBackLabel: UILabel!
    @IBOutlet weak var numberOfCharFrontLabel: UILabel!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var sideALabel: UILabel!
    @IBOutlet weak var sideBLabel: UILabel!
    @IBOutlet weak var sideAcamImage: UIButton!
    @IBOutlet weak var sideBcamImage: UIButton!
    
    var maxCharacter = 100
    
    weak var delegate: AddCardImageDelegate?
    var card: Card?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addImageFront(_ sender: Any) {
        if let _ = frontImage.image {
            self.frontImage.image = nil
            self.card?.front_content?.image = nil
            self.sideAcamImage.setImage(UIImage(named: "camAdd"), for: .normal)
        } else {
            self.delegate?.selectImage { image in
                self.frontImage.image = image
                self.card?.front_content?.image = image?.pngData()
                self.sideAcamImage.setImage(UIImage(named: "camDelete"), for: .normal)
            }
        }
        
    }
    
    @IBAction func addImageBack(_ sender: Any) {
        if let _ = backImage.image {
            self.backImage.image = nil
            self.card?.back_content?.image = nil
            self.sideBcamImage.setImage(UIImage(named: "camAdd"), for: .normal)
        } else {
            self.delegate?.selectImage { image in
                self.backImage.image = image
                self.card?.back_content?.image = image?.pngData()
                self.sideBcamImage.setImage(UIImage(named: "camDelete"), for: .normal)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        self.card?.front_content?.text = frontSideTextField.text
        self.card?.back_content?.text = backSideTextField.text
        
        numberOfCharFrontLabel.text = String("\(frontSideTextField.text.count)/100")
        numberOfCharBackLabel.text = String("\(backSideTextField.text.count)/100")
        
        if frontSideTextField.text.count >= maxCharacter {
            self.frontSideTextField.endEditing(true)
        }
        
        if backSideTextField.text.count >= maxCharacter {
            self.backSideTextField.endEditing(true)
        }
    }
    
    
    func configure(card: Card) {
        self.card = card
        
        frontSideTextField.text = card.front_content?.text
        backSideTextField.text = card.back_content?.text
        
        sideALabel.text = NSLocalizedString("side_a", comment: "")
        sideBLabel.text = NSLocalizedString("side_b", comment: "")
        
        frontImage.image = card.front_content?.image.flatMap(UIImage.init(data: ))
        backImage.image = card.back_content?.image.flatMap(UIImage.init(data: ))
        
        frontSideTextField.delegate = self
        backSideTextField.delegate = self
        
        numberOfCharFrontLabel.text = String("\(frontSideTextField.text.count)/100")
        numberOfCharBackLabel.text = String("\(backSideTextField.text.count)/100")
        
        frontSideTextField.layer.cornerRadius = 4
        backSideTextField.layer.cornerRadius = 4
        
        if let sideAcontent = card.front_content, let _ = sideAcontent.image {
            sideAcamImage.setImage(UIImage(named: "camDelete"), for: .normal)
        } else {
            sideAcamImage.setImage(UIImage(named: "camAdd"), for: .normal)
        }
        
        if let sideBcontent = card.back_content, let _ =  sideBcontent.image {
            sideBcamImage.setImage(UIImage(named: "camDelete"), for: .normal)
        } else {
            sideBcamImage.setImage(UIImage(named: "camAdd"), for: .normal)
        }
                
    }
}
