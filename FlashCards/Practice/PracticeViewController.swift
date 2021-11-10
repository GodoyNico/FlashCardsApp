//
//  ViewController.swift
//  PraticaFlashCards
//
//  Created by Nicolas Godoy on 27/10/21.
//

import UIKit

typealias PracticeFeedback = (remembered: Int, noRemembered: Int, deck: Deck?)

class PracticeViewController: UIViewController {
    // MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var deck: Deck?
    var practiceData: PracticeData?
    var cards: [Card] = []
    var isFront: Bool = false
    var flipped: Bool = false
    var currentCard: Int = 0
    var qntSelected: Int = 0
    var feedbackSegueID: String = "goToFeedback"
    var feedback: PracticeFeedback = PracticeFeedback(remembered: 0, noRemembered: 0, deck: nil)
    
    // MARK: - Outlets
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var rememberedButton: UIButton!
    @IBOutlet weak var noRememberedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.title = deck?.title
        
        rememberedButton.isHidden = true
        noRememberedButton.isHidden = true
        
        generateCards()
        
        counterLabel.text = "1/\(deck!.cards!.count)"
        
        cardLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.flip(_:)))
        cardView.addGestureRecognizer(tap)
        
        toPractice()
    }
    
    func configure(deck: Deck) {
        self.deck = deck
        self.feedback.deck = self.deck
    }
    
    @IBAction func endPractice(_ sender: Any) {
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
            print("Seguiu a prática")
        }
        
        let confirmAction = UIAlertAction(title: "Confirm",
                                          style: .default) { (action) in
            print("Parou a prática")
        }
        
        let alert = UIAlertController(title: "Parar prática",
                                      message: "Deseja realmente interromper a prática?",
                                      preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true) {
        }
    }
    
    @IBAction func flipCard(_ sender: Any) {
        print("Virou")
    }
    
    @IBAction func noRemembered(_ sender: Any) {
        if currentCard < cards.count {
            
            feedback.noRemembered += 1
            let card = cards[currentCard]
            
            // Progress history
            let newPractice = Progress(context: self.context)
            newPractice.date = Date.now
            newPractice.status = false
            newPractice.card = card
            card.addToProgress(newPractice)
            
            // Progress Counter
            if card.progress_counter == 5 {
                
                if let deck = card.deck {
                    deck.progress_counter = deck.progress_counter - 1
                }
                
                card.progress_counter = card.progress_counter - 1
                
            } else if card.progress_counter > 0 {
                card.progress_counter = card.progress_counter - 1
            }
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            if currentCard == cards.count-1 {
                finished()
            } else {
                currentCard += 1;
                counterLabel.text = "\(currentCard+1)/\(deck!.cards!.count)"
                toPractice()
            }
        }
    }
    
    @IBAction func remembered(_ sender: Any) {
        if currentCard < cards.count {
            
            feedback.remembered += 1
            let card = cards[currentCard]
            
            // Progress History
            let newPractice = Progress(context: self.context)
            newPractice.date = Date.now
            newPractice.status = true
            newPractice.card = card
            card.addToProgress(newPractice)
            
            // Progress Counter
            if card.progress_counter < 5 {
                
                if card.progress_counter == 4 {
                    if let deck = card.deck  {
                        deck.progress_counter = deck.progress_counter + 1
                    }
                }
                
                card.progress_counter = card.progress_counter + 1
            }
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            if currentCard == cards.count-1 {
                finished()
            } else {
                currentCard += 1;
                counterLabel.text = "\(currentCard+1)/\(deck!.cards!.count)"
                toPractice()
            }
        }
    }
    
    func cardLayout() {
        view.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        counterLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)
        
        cardView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
        cardView.layer.cornerRadius = 16
        
        //sideLabel.layer.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
        sideLabel.layer.backgroundColor = CGColor(red: 157, green: 126, blue: 204, alpha: 10.0)
        sideLabel.layer.cornerRadius = 30
        sideLabel.layer.borderWidth = 3
        sideLabel.layer.borderColor = CGColor(red: 157, green: 126, blue: 204, alpha: 10.0)
        //        sideLabel.textColor = UIColor(red: 166.0, green: 164.0, blue: 164.0, alpha: 10.0)
        //sideLabel.textColor = UIColor.black
        
        imageView.layer.cornerRadius = 16
        
        sideView.layer.cornerRadius = 15
        sideView.layer.borderWidth = 3
        //sideView.layer.borderColor = CGColor.init(red: 201, green: 202, blue: 210, alpha: 1.0)
        //sideView.layer.backgroundColor = UIColor.gray
        //sideView.backgroundColor = UIColor.gray
        
        rememberedButton.layer.cornerRadius = 8
        noRememberedButton.layer.cornerRadius = 8
    }
    
    func finished() {
        performSegue(withIdentifier: self.feedbackSegueID, sender: feedback)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let feedbackViewController = segue.destination as? FeedbackViewController,
              let practiceFeedback = sender as? PracticeFeedback else { return }
        
        feedbackViewController.deckConfig(data: practiceFeedback)
    }
    
    func generateCards() {
        self.cards = self.deck?.cards?.allObjects as! [Card]
        
        if self.cards.isEmpty {
            for i in 1...5 {
                let newCard = Card(context: self.context)
                
                let fContent = Content(context: self.context)
                fContent.text = "frente \(i)"
                
                let vContent = Content(context: self.context)
                vContent.text = "verso \(i)"
                
                newCard.front_content = fContent
                newCard.back_content = vContent
                
                newCard.deck = self.deck
                
                // Save the Data
                do {
                    try self.context.save()
                } catch { }
            }
            generateCards()
        }
    }
    
    func toPractice() {
        flipped = false
        rememberedButton.isHidden = true
        noRememberedButton.isHidden = true
        isFront = self.deck?.isFront ?? true
        contentLabel.text = isFront ? cards[currentCard].front_content?.text : cards[currentCard].back_content?.text
    }
    
    @objc func flip(_ sender: UITapGestureRecognizer? = nil) {
        
        if isFront {
            sideLabel.text = "B"
            contentLabel.text = cards[currentCard].back_content?.text
            isFront = false
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: .none, completion: nil)
        } else {
            sideLabel.text = "A"
            contentLabel.text = cards[currentCard].front_content?.text
            isFront = true
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromRight, animations: .none, completion: nil)
        }
        
        if !flipped {
            rememberedButton.isHidden = false
            noRememberedButton.isHidden = false
            flipped = true
        }
    }
}

