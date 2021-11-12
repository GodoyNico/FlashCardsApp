//
//  NewDeckTableViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

class NewDeckTableViewCell: UITableViewCell {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var deck: Deck?
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var newDeckTextfield: UITextField!
    @IBOutlet weak var divisorView: UIView!
    
    @IBAction func setDeckTitle(_ sender: Any) {
        self.deck?.title = newDeckTextfield.text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func configure(newDeck: Deck?) {
        viewBackground.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        self.deck = newDeck
        newDeckTextfield.text = self.deck?.title
        
        divisorView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
