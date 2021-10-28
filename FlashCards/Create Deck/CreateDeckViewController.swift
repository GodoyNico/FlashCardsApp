//
//  CreateDeckViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 26/10/21.
//

import UIKit

class CreateDeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var decks: [Deck] = []
    var cards: [Card] = []
    
    let deckNameCell: String = "NewDeckCell"
    let newCardCell: String = "NewCardCell"
    
    @IBOutlet weak var createDeckTableView: UITableView!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var deckDone: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDeckTableView.delegate = self
        createDeckTableView.dataSource = self
                
        fetchDecks()
        
    }
    
    @IBAction func createCard(_ sender: Any) {
        
        let newCard = Card(context: self.context)
        newCard.id = UUID()
        //        newCard.front_content?.text =
        //        newCard.back_content?.text =
        //        newCard.front_content?.image =
        //        newCard.back_content?.image =
        
        // Save the Data
        do {
            try self.context.save()
        } catch { }
        
    }
    
    @IBAction func createDeck(_ sender: Any) {
        
        // Create a Deck Object
        let newDeck = Deck(context: self.context)
        //newDeck.title = newDeckTextfield.text
        newDeck.id = UUID()
        newDeck.created_date = Date.now
        
        // Save the Data
        do {
            try self.context.save()
        } catch { }
        
        // Re-Fetch the Data
        self.fetchDecks()
        
    }
    
    //    func countCards() -> Int {
    //        let numberOfCards = cards.count
    //        numberOfCardsLabel.text = "\(numberOfCards) cards"
    //        return numberOfCards
    //    }
    
    func fetchDecks() {
        do {
            self.decks = try context.fetch(Deck.fetchRequest())
            DispatchQueue.main.async {
                self.createDeckTableView.reloadData()
            }
        } catch { }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let deckNameCell = createDeckTableView.dequeueReusableCell(withIdentifier: deckNameCell ) as! NewDeckTableViewCell
            return deckNameCell
            
        } else {
            
            let newCardCell = createDeckTableView.dequeueReusableCell(withIdentifier: newCardCell ) as! NewCardTableViewCell
            return newCardCell
        }
    }
}
