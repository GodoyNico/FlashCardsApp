//
//  DeleteDeckTableViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 10/11/21.
//

import UIKit


protocol DeleteDeckDelegate: AnyObject {
    
    func didTapDeleteButton(fromCell cell: UITableViewCell)
    
}


class DeleteDeckTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteDeckBackground: UIView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var deck: Deck?
    
    weak var delegate: DeleteDeckDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(deck: Deck?) {
        deleteDeckBackground.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        self.deck = deck
    }
    
    @IBAction func deleteDeck(_ sender: Any) {
        delegate?.didTapDeleteButton(fromCell: self)
    }
    
}
