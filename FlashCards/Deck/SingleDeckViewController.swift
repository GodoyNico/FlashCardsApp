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
    let goToEditSegueID: String = "goToEdit"
    let goToAddCardsSegueID: String = "goToAddCards"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let deckSelected = self.deck {
            
            deckTtitleLabel.text = deckSelected.title
            practiceButton.layer.cornerRadius = 10
            practiceButton.backgroundColor = UIColor(named: "gray1")
            
        } else {
            
            self.deck = getRandomDeck()
            
            if let deckSelected = self.deck {
                deckTtitleLabel.text = deckSelected.title
                practiceButton.layer.cornerRadius = 10
                practiceButton.backgroundColor = UIColor(named: "gray1")
            } else {
                // TODO : EMPTY STATE
                print("Não há decks criados ainda")
            }
            
        }
        
        deckProgressCircleView.setValue(value: 0.7)
        deckProgressCircleView.trackColor = UIColor.gray
        deckProgressCircleView.progressColor = UIColor.black
        
    }
    
    func configure(deck: Deck) {
        self.deck = deck
    }
    
    func getRandomDeck() -> Deck? {
        do {
            let myDecks = try context.fetch(Deck.fetchRequest())
            if !myDecks.isEmpty {
                return myDecks.randomElement()
            }
        } catch { }
        
        return nil
    }
    
    @IBAction func toPractice(_ sender: Any) {
        performSegue(withIdentifier: self.goToPracticeSegueID, sender: deck)
    }
    
    @IBAction func toEdit(_ sender: Any) {
        performSegue(withIdentifier: self.goToEditSegueID, sender: deck)
    }
    
    @IBAction func toAddCards(_ sender: Any) {
        performSegue(withIdentifier: self.goToAddCardsSegueID, sender: deck)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == goToEditSegueID {
            // TODO : Configurar tela de edit
            /*
            guard let editViewController = segue.destination as? EditViewController, let deck = sender as? Deck else { return }

            editViewController.configure(deck: deck)
            */
        } else if segue.identifier == goToPracticeSegueID {
            
            guard let practiceViewController = segue.destination as? PracticeViewController, let deck = sender as? Deck else { return }
            
            practiceViewController.configure(deck: deck)
            
        } else if segue.identifier == goToAddCardsSegueID {
            // TODO : Configurar tela de add cards
            /*
            guard let addViewController = segue.destination as? AddCardsViewController, let deck = sender as? Deck else { return }

            addViewController.configure(deck: deck)
            */
        }
        
    }
    
}
