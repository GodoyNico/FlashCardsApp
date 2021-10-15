//
//  DeckViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 14/10/21.
//

import UIKit

class DeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let deckCellId: String = "Deck-Cell-ID"
    
    var decks: [Deck] = []

    @IBOutlet weak var decksTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        decksTableView.delegate = self
        decksTableView.dataSource = self
        
        fetchDecks()
    }
    
    func fetchDecks() {
        do {
            self.decks = try context.fetch(Deck.fetchRequest())
            DispatchQueue.main.async {
                self.decksTableView.reloadData()
                /*
                for deck in self.decks {
                    print("Title: \(deck.title)")
                    print("ID: \(deck.id)")
                    print("Date: \(deck.create_date)")
                    print("Progress: \(deck.progress)")
                    print("Cards: \(deck.cards?.count)")
                    print("-----------------------------\n")
                }
                */
                
            }
        } catch { }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    // MARK: List Decks
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = decksTableView.dequeueReusableCell(withIdentifier: deckCellId) as! DeckTableViewCell

        let deck = self.decks[indexPath.row]
        
        cell.titleDeckLabel.text = deck.title
        
        return cell
    }
    
    // MARK: Edit Deck
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let deck = self.decks[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Deck", message: "Edit Title: ", preferredStyle: .alert)
        
        alert.addTextField()
        
        let textField = alert.textFields!.first
        textField?.text = deck.title

        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            // Get textfield for the alert
            let textField = alert.textFields!.first
            
            // Edit title Deck Object
            deck.title = textField?.text
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.fetchDecks()
            
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    // MARK: Add Deck
    @IBAction func addDeck(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Deck", message: "What is the deck name?", preferredStyle: .alert)
        
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // Get textfield for the alert
            let textField = alert.textFields!.first
            
            // Create a Deck Object
            let newDeck = Deck(context: self.context)
            newDeck.title = textField?.text
            newDeck.id = UUID()
            newDeck.create_date = Date.now
            newDeck.cards = []
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.fetchDecks()
            
        }
        
        alert.addAction(submitButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: Delete Deck
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create Swipe Action
        let action =  UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which Deck to Remove
            let deckToRemove = self.decks[indexPath.row]
            
            // Remove the Deck
            self.context.delete(deckToRemove)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.fetchDecks()

        }
        
        // Return Swipe Action
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
}
