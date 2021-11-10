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
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var feedbackText: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deckNameLabel: UILabel!
    @IBOutlet weak var practiceAgain: UIButton!
    @IBOutlet weak var goToDecks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        practiceAgain.layer.cornerRadius = 8
        goToDecks.layer.cornerRadius = 8
        
        feedbackLabel.text = "Parabéns!"
        feedbackText.text = "Você memorizou"
        counterLabel.text = "\(practiceFeedback!.remembered)/\(practiceFeedback!.deck!.cards!.count)"
        deckNameLabel.text = practiceFeedback?.deck?.title
    }
    
    @IBAction func practiceAgain( _ seg: UIStoryboardSegue) {
        if let deckController = navigationController?.viewControllers[1] {
            navigationController?.popToViewController(deckController, animated: true)
        }
    }
    
    @IBAction func myDecks( _ seg: UIStoryboardUnwindSegueSource) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func deckConfig(data: PracticeFeedback) {
        self.practiceFeedback = data
    }
}
