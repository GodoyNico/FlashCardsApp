//
//  FeedbackViewController.swift
//  PraticaFlashCards
//
//  Created by Nicolas Godoy on 27/10/21.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    var practiceFeedback: PracticeFeedback?
    let deckSegueId: String = "goToSingleDeck"
    let myDecksSegueId: String = "goToMyDecks"
    
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var practiceAgain: UIButton!
    @IBOutlet weak var goToDecks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackView.layer.cornerRadius = 16
        practiceAgain.layer.cornerRadius = 8
        goToDecks.layer.cornerRadius = 8
        
        feedbackLabel.text = "Parabéns! Você memorizou \(practiceFeedback!.remembered)/\(practiceFeedback!.deck!.cards!.count)"
    }
    
    @IBAction func practiceAgain(_ sender: Any) {
        performSegue(withIdentifier: self.deckSegueId, sender: nil)
    }
    
    @IBAction func myDecks(_ sender: Any) {
        performSegue(withIdentifier: self.myDecksSegueId, sender: nil)
    }
    
    
    func deckConfig(data: PracticeFeedback) {
        self.practiceFeedback = data
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let singleDeckViewController = segue.destination as? SingleDeckViewController, let deck = sender as? Deck else { return }
//
//        singleDeckViewController.deck = deck
//    }
}
