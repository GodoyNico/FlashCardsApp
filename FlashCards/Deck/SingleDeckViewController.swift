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
    let goToPracticeSegueID: String = "goToPractice"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        deckTtitleLabel.text = deck?.title
        practiceButton.layer.cornerRadius = 10
        practiceButton.backgroundColor = UIColor(named: "gray1")
    }

    @IBAction func toPractice(_ sender: Any) {
        performSegue(withIdentifier: self.goToPracticeSegueID, sender: deck)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let practiceViewController = segue.destination as? PracticeViewController, let deck = sender as? Deck else { return }

        practiceViewController.configure(deck: deck)
    }
    
}
