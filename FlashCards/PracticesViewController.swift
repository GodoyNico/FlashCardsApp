//
//  PracticeViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 19/10/21.
//

import UIKit

typealias PracticesFeedback = (remembered: Int, noRemembered: Int)

class PracticesViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var practiceData: PracticeData?
    var cards: [Card] = []
    var currentCard: Int = 0
    var flipped: Bool = false
    var feedback: PracticeFeedback = PracticeFeedback(remembered: 0, noRemembered: 0)
    
    var feedbackSegueID: String = "goToFeedback"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rememberedButton: UIButton!
    @IBOutlet weak var noRememberedButton: UIButton!
    
    var isFront = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rememberedButton.isHidden = true
        noRememberedButton.isHidden = true
        
        print("\(practiceData!.countCards)")
        print("\(practiceData!.isFront)")
        
        generateCards()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.flip(_:)))
        cardView.addGestureRecognizer(tap)
        
        toPractice()
    }
    
    @IBAction func remembered(_ sender: Any) {
        if currentCard <= cards.count-1 {
            feedback.remembered += 1
            let card = cards[currentCard]
            let newPractice = Progress(context: self.context)
            newPractice.date = Date.now
            newPractice.status = true
            newPractice.card = card
            card.addToProgress(newPractice)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            if currentCard == cards.count-1 {
                finished()
            } else {
                currentCard += 1;
                toPractice()
            }
        }
    }
    
    @IBAction func noRemembered(_ sender: Any) {
        if currentCard <= cards.count-1 {
            feedback.noRemembered += 1
            let card = cards[currentCard]
            let newPractice = Progress(context: self.context)
            newPractice.date = Date.now
            newPractice.status = false
            newPractice.card = card
            card.addToProgress(newPractice)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            if currentCard == cards.count-1 {
                finished()
            } else {
                currentCard += 1;
                toPractice()
            }
        }
    }
    
    func finished() {
        performSegue(withIdentifier: self.feedbackSegueID, sender: feedback)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let feedbackViewController = segue.destination as? FeedbackViewController,
            let practiceFeedback = sender as? PracticeFeedback else { return }
        
        feedbackViewController.practiceFeedback = practiceFeedback
    }
    
    func generateCards() {
        //cria cópia das cartas do deck
        var initialSet = Set((practiceData?.selectedDeck.cards?.allObjects as! [Card]).compactMap() { $0.self})
        
        //Seleciona cartas aleatórias sem repetir
        for _ in 0..<practiceData!.countCards {
            let selectedCard = initialSet.randomElement()!
            cards.append(selectedCard)
            initialSet.remove(selectedCard)
        }
    }
    
    func toPractice() {
        flipped = false
        rememberedButton.isHidden = true
        noRememberedButton.isHidden = true
        isFront = practiceData!.isFront
        contentLabel.text = isFront ? cards[currentCard].front_content?.text : cards[currentCard].back_content?.text
    }
    
    @objc func flip(_ sender: UITapGestureRecognizer? = nil) {
        
        if isFront {
            contentLabel.text = cards[currentCard].back_content?.text
            isFront = false
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromRight, animations: .none, completion: nil)
        } else {
            contentLabel.text = cards[currentCard].front_content?.text
            isFront = true
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: .none, completion: nil)
        }
        
        if !flipped {
            rememberedButton.isHidden = false
            noRememberedButton.isHidden = false
            flipped = true
        }
    }
}
