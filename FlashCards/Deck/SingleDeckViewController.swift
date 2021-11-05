//
//  DeckViewController.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 28/10/21.
//

import UIKit

class SingleDeckViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var deck: Deck?

    @IBOutlet weak var deckTtitleLabel: UILabel!
    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet weak var deckProgressCircleView: CircularProgressView!
    
    let goToPracticeSegueID: String = "goToPractice"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let deckSelected = self.deck {
            deckTtitleLabel.text = deckSelected.title
            practiceButton.layer.cornerRadius = 10
            practiceButton.backgroundColor = UIColor(named: "gray1")
        } else {
            self.deck = Deck(context: self.context)
            deck?.title = "teste"
            deckTtitleLabel.text = deck!.title
            practiceButton.layer.cornerRadius = 10
            practiceButton.backgroundColor = UIColor(named: "gray1")
        }
        deckProgressCircleView.setValue(value: 0.7)
        deckProgressCircleView.trackColor = UIColor.gray
        deckProgressCircleView.progressColor = UIColor.black
        
    }

    @IBAction func toPractice(_ sender: Any) {
        performSegue(withIdentifier: self.goToPracticeSegueID, sender: deck)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let practiceViewController = segue.destination as? PracticeViewController, let deck = sender as? Deck else { return }

        practiceViewController.configure(deck: deck)
    }
    
    func configure(deck: Deck) {
        self.deck = deck
        
        
    }
    
}
