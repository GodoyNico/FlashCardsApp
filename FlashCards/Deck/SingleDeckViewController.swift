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

    @IBOutlet weak var deckTitleLabel: UILabel!
    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet weak var deckProgressCircleView: CircularProgressView!
    @IBOutlet weak var deckProgressLabel: UILabel!
    
    let goToPracticeSegueID: String = "goToPractice"
    let goToEditSegueID: String = "goToEdit"
    let goToAddCardsSegueID: String = "goToAddCards"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let deckSelected = self.deck {
            
            deckTitleLabel.text = deckSelected.title
            practiceButton.layer.cornerRadius = 10
            practiceButton.backgroundColor = UIColor(named: "gray1")
            
            if let cardsList = deckSelected.cards {
                deckProgressLabel.text = "\(deckSelected.progress_counter)/\(cardsList.count)"
                deckProgressCircleView.setValue(value: Double(deckSelected.progress_counter)/Double(cardsList.count))
            } else {
                deckProgressCircleView.setValue(value: 0)
            }
            
        } else {
            
            self.deck = getRandomDeck()
            
            if let deckSelected = self.deck {
                deckTitleLabel.text = deckSelected.title
                practiceButton.layer.cornerRadius = 10
                practiceButton.backgroundColor = UIColor(named: "gray1")
            } else {
                // TODO: EMPTY STATE
                print("Não há decks criados ainda")
            }
            
            deckProgressCircleView.setValue(value: 0)
           
        }
    
        deckProgressCircleView.trackColor = UIColor.gray
        deckProgressCircleView.progressColor = UIColor.black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
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
            
            guard let editDeckViewController = segue.destination as? CreateDeckViewController, let deck = sender as? Deck else { return }

            editDeckViewController.configure(deck: deck, screen: .edit)

        } else if segue.identifier == goToPracticeSegueID {
            
            guard let practiceViewController = segue.destination as? PracticeViewController, let deck = sender as? Deck else { return }
            
            practiceViewController.configure(deck: deck)
            
        } else if segue.identifier == goToAddCardsSegueID {
            
            guard let editDeckViewController = segue.destination as? CreateDeckViewController, let deck = sender as? Deck else { return }

            editDeckViewController.configure(deck: deck, screen: .addCard)

        }
        
    }
    
}
