//
//  CreateDeckViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 26/10/21.
//

import UIKit


class CreateDeckViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var decks: [Deck] = []
    
    @IBOutlet weak var deckDone: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var newDeckTextfield: UITextField!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    
    @IBAction func createDeck(_ sender: Any) {

        // Create a Deck Object
        let newDeck = Deck(context: self.context)
        newDeck.title = newDeckTextfield.text
        newDeck.id = UUID()
        newDeck.created_date = Date.now

        // Save the Data
        do {
            try self.context.save()
        } catch { }

        // Re-Fetch the Data
        self.fetchDecks()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDecks()
    }
    
    func fetchDecks() {
//        do {
//            self.decks = try context.fetch(Deck.fetchRequest())
//            DispatchQueue.main.async {
//                self.decksTableView.reloadData()
//            }
//        } catch { }
//
    }
}
