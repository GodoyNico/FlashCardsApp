//
//  DeckDetailsViewController.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 15/10/21.
//

import UIKit

typealias PracticeData = (countCards: Int, isFront: Bool)

class DeckDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var deck: Deck?
    var cards: [Card] = []
    var practiceSegueID: String = "goToPractice"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var cardCellId: String = "Card-Cell-ID"
        
    @IBOutlet weak var cardsTableView: UITableView!
    @IBAction func practice(_ sender: Any) {
        
        let alert = UIAlertController(title: "Practice", message: "How many cards do you want practice?", preferredStyle: .alert)
        
        alert.addTextField()
        
        let frontButton = UIAlertAction(title: "Frente", style: .default) { [self] (action) in
            guard let text = alert.textFields?.first?.text,
                  let countCards = Int(text) else { return }
            let practiceData = PracticeData(countCards: countCards, isFront: true)
            performSegue(withIdentifier: self.practiceSegueID, sender: practiceData)
        }
        
        let backButton = UIAlertAction(title: "Verso", style: .default) { [self] (action) in
            guard let text = alert.textFields?.first?.text,
                  let countCards = Int(text) else { return }
            let practiceData = PracticeData(countCards: countCards, isFront: false)
            performSegue(withIdentifier: self.practiceSegueID, sender: practiceData)
        }
        
        alert.addAction(frontButton)
        alert.addAction(backButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let practiceViewController = segue.destination as? PracticeViewController,
            let practiceData = sender as? PracticeData else { return }
        
        practiceViewController.practiceData = practiceData
    }
    
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
    
    // MARK: Delete Card
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create Swipe Action
        let action =  UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which Deck to Remove
            let cardToRemove = self.cards[indexPath.row]
            
            // Remove the Deck
            self.context.delete(cardToRemove)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.fetchCards()
            
        }
        
        // Return Swipe Action
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    // MARK: Edit Card
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let card = self.cards[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Card", message: "Edit Title: ", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addTextField()
        
        let textFieldFront = alert.textFields!.first
        textFieldFront?.text = card.front_content?.text
        
        let textFieldBack = alert.textFields!.last
        textFieldBack?.text = card.back_content?.text
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            // Get textfield for the alert
            let textFieldFront = alert.textFields!.first
            let textFieldBack = alert.textFields!.last
            
            let frontContent = Content(context: self.context)
            frontContent.text = textFieldFront?.text
            
            let backContent = Content(context: self.context)
            backContent.text = textFieldBack?.text
            
            // Edit title Deck Object
            card.front_content = frontContent
            card.back_content = backContent
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.fetchCards()
            
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}
