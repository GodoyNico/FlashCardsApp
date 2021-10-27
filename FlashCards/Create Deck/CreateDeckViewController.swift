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
    var cards: [Card] = []
    
    @IBOutlet weak var deckDone: UIBarButtonItem!
    @IBOutlet weak var newDeckTextfield: UITextField!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    private let swipeableView: UIView = {
        // Initialize View
        let view = UIView(frame: CGRect(origin: .init(x: 45, y: 400), size: CGSize(width: 300.0, height: 500.0)))

        // Configure View
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add to View Hierarchy
        view.addSubview(swipeableView)

        // Initialize Swipe Gesture Recognizer
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        
        // Configure Swipe Gesture Recognizer
        swipeGestureRecognizerRight.direction = .right
        swipeGestureRecognizerLeft.direction = .left

        // Add Swipe Gesture Recognizer
        swipeableView.addGestureRecognizer(swipeGestureRecognizerRight)
        swipeableView.addGestureRecognizer(swipeGestureRecognizerLeft)
        
        fetchDecks()
    
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        // Current Frame
        var frame = swipeableView.frame

        switch sender.direction {
        case .left:
            frame.origin.x -= 250.0
        case .right:
            frame.origin.x += 250.0
        default:
            break
        }
        
        UIView.animate(withDuration: 0.25) {
            self.swipeableView.frame = frame
        }
    }
    
    func countCards() -> Int {
        let numberOfCards = cards.count
        numberOfCardsLabel.text = "\(numberOfCards) cards"
        return numberOfCards
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
