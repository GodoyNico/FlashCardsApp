//
//  DeckViewController.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 28/10/21.
//

import UIKit

class SingleDeckViewController: UIViewController {
    
    var deck: Deck?

    @IBOutlet weak var deckTtitleLabel: UILabel!
    @IBOutlet weak var practiceButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        deckTtitleLabel.text = deck?.title
        practiceButton.layer.cornerRadius = 10
        practiceButton.backgroundColor = UIColor(named: "gray1")
    }

}
