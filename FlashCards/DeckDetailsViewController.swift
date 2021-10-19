//
//  DeckDetailsViewController.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 15/10/21.
//

import UIKit

class DeckDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var deck: Deck?
    var cards: [Card] = []

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    var cardCellId: String = "Card-Cell-ID"
    
    @IBOutlet weak var cardsTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = deck?.title
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
       
        fetchCards()
    }
    
    func fetchCards() {
        self.cards = self.deck?.cards?.objectEnumerator().allObjects as! [Card]
        
        DispatchQueue.main.async {
            self.cardsTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cards = deck?.cards?.count else {
            return 0
        }
        return cards
    }
    
    // MARK: List Cards
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cardsTableView.dequeueReusableCell(withIdentifier: cardCellId) as! CardTableViewCell

        let card = self.cards[indexPath.row] as Card
        
        cell.frontContentCell.text = card.front_content?.text
        cell.backContentCell.text = card.back_content?.text

        return cell
        
    }
    
    @IBAction func addCard(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Card", message: "Create your card:", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // Get textfield for the alert
            let textFieldFront = alert.textFields!.first
            
            let frontContent = Content(context: self.context)
            frontContent.text = textFieldFront?.text
            
            let textFieldBack = alert.textFields!.last
            
            let backContent = Content(context: self.context)
            backContent.text = textFieldBack?.text
            
            // Create a Deck Object
            let newCard = Card(context: self.context)
            newCard.front_content = frontContent
            newCard.back_content = backContent
            newCard.id = UUID()
            newCard.progress = []
            
            self.deck?.addToCards(newCard)
            newCard.deck = self.deck
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.fetchCards()
            
        }
        
        alert.addAction(submitButton)
        
        self.present(alert, animated: true, completion: nil)
            
    }
    
}
