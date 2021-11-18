//
//  ViewController.swift
//  PraticaFlashCards
//
//  Created by Nicolas Godoy on 27/10/21.
//

import UIKit

typealias PracticeFeedback = (remembered: Int, noRemembered: Int, deck: Deck?)
typealias PracticeData = (countCards: Int, isFront: Bool, selectedDeck: Deck)

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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sideStatus: UIImageView!
    @IBOutlet weak var rememberedButton: UIButton!
    @IBOutlet weak var noRememberedButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.title = deck?.title
        
        rememberedButton.isHidden = true
        noRememberedButton.isHidden = true
        
        stopButton.title = NSLocalizedString("stop", comment: "")
        
        fetchCards()
        
        counterLabel.text = "1/\(deck!.cards!.count)"
        
        cardLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.flip(_:)))
        cardView.addGestureRecognizer(tap)
        
        toPractice()
    }
    
    func configure(deck: Deck) {
        self.deck = deck
        self.isFront = deck.isFront
        self.feedback.deck = self.deck
    }
    
    @IBAction func endPractice(_ sender: Any) {
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel) { (action) in
            return
        }
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            self.finished()
        }
        
        let alert = UIAlertController(title: NSLocalizedString("stop_practice", comment: ""),
                                      message: NSLocalizedString("stop_practice_text", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true) {
        }
    }
    
    @IBAction func noRemembered(_ sender: Any) {
        if currentCard < cards.count {
            feedback.noRemembered += 1
            let card = cards[currentCard]
            
            let newPractice = Progress(context: self.context)
            newPractice.date = Date()
            newPractice.status = false
            newPractice.card = card
            card.addToProgress(newPractice)
            
            if card.progress_counter == 5 {
                if let deck = card.deck {
                    deck.progress_counter = deck.progress_counter - 1
                }
                card.progress_counter = card.progress_counter - 1
            } else if card.progress_counter > 0 {
                card.progress_counter = card.progress_counter - 1
            }
            
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
            
            let newPractice = Progress(context: self.context)
            newPractice.date = Date()
            newPractice.status = true
            newPractice.card = card
            card.addToProgress(newPractice)
            
            if card.progress_counter < 5 {
                if card.progress_counter == 4 {
                    if let deck = card.deck  {
                        deck.progress_counter = deck.progress_counter + 1
                    }
                }
                card.progress_counter = card.progress_counter + 1
            }
            
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
        
        cardColor()
        cardView.layer.cornerRadius = 16
        
        imageView.layer.cornerRadius = 16
        
        rememberedButton.layer.cornerRadius = 8
        noRememberedButton.layer.cornerRadius = 8
        
        rememberedButton.layer.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.button)?.cgColor
        noRememberedButton.layer.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)?.cgColor
    }
    
    func cardColor() {
        if isFront == true {
            cardView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
            sideStatus.image = UIImage(named: "iconA")
            flipButton.setImage(UIImage(named: "setaFlipA"), for: .normal)
            
        } else {
            cardView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Secondary)
            sideStatus.image = UIImage(named: "iconB")
            flipButton.setImage(UIImage(named: "setaFlipB"), for: .normal)

        }
    }
    
    func finished() {
        performSegue(withIdentifier: self.feedbackSegueID, sender: feedback)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let feedbackViewController = segue.destination as? FeedbackViewController,
              let practiceFeedback = sender as? PracticeFeedback else { return }
        
        feedbackViewController.deckConfig(data: practiceFeedback)
    }
    
    func fetchCards() {
        self.cards = self.deck?.cards?.allObjects as! [Card]

    }
    
    func toPractice() {
        flipped = false
        rememberedButton.isHidden = true
        noRememberedButton.isHidden = true
        
        isFront = self.deck?.isFront ?? true
        let cardContent = isFront ? cards[currentCard].front_content : cards[currentCard].back_content
        
        contentLabel.text = cardContent?.text
        imageView.image = cardContent?.image.flatMap(UIImage.init(data: ))
        
        cardView.backgroundColor = UIColor(designSystem: isFront ? DesignSystem.AssetsColor.color2Primary : DesignSystem.AssetsColor.color1Secondary )
        sideStatus.image = UIImage(named: isFront ? "iconA" : "iconB")
        flipButton.setImage(UIImage(named: isFront ? "setaFlipA" : "setaFlipB"), for: .normal)
        
    }
    
    
    @IBAction func flipButton(_ sender: UIButton) { flip() }
    
    @objc func flip(_ sender: UITapGestureRecognizer? = nil) {
        if isFront {
            contentLabel.text = cards[currentCard].back_content?.text
            imageView.image = cards[currentCard].back_content?.image.flatMap(UIImage.init(data: ))
            cardView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Secondary )
            sideStatus.image = UIImage(named: "iconB")
            flipButton.setImage(UIImage(named: "setaFlipB"), for: .normal)
            
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: .none, completion: nil)
            isFront = false

        } else {
            contentLabel.text = cards[currentCard].front_content?.text
            imageView.image = cards[currentCard].front_content?.image.flatMap(UIImage.init(data: ))
            cardView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary )

            sideStatus.image = UIImage(named: "iconA")
            flipButton.setImage(UIImage(named: "setaFlipA"), for: .normal)
            
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromRight, animations: .none, completion: nil)
            isFront = true
        }
        
        if !flipped {
            rememberedButton.isHidden = false
            noRememberedButton.isHidden = false
            flipped = true
        }
    }
}

