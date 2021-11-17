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
    @IBOutlet weak var deleteLabel: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var deck: Deck?
    weak var delegate: DeleteDeckDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(deck: Deck?) {
        deleteDeckBackground.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        deleteLabel.titleLabel?.text = NSLocalizedString("delete_deck", comment: "")
        
        self.deck = deck
    }
    
    @IBAction func deleteDeck(_ sender: Any) {
        delegate?.didTapDeleteButton(fromCell: self)
    }
    
}
