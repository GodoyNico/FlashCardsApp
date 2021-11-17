//
//  SwitchTableViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 08/11/21.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var deck: Deck?
    
    @IBOutlet weak var switchBackground: UIView!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var sideB: UILabel!
    @IBOutlet weak var sideA: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        self.deck?.isFront = !(switchButton.isOn)
    }
    
    func configure(newDeck: Deck?) {
        self.deck = newDeck
        switchButton.isOn = !(self.deck?.isFront ?? true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchButton.onTintColor = .blue
        switchBackground.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        switchButton.onTintColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)
        switchButton.tintColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Secondary)
        
        sideA.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Secondary)
        sideB.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
