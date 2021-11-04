//
//  FeedbackViewController.swift
//  PraticaFlashCards
//
//  Created by Nicolas Godoy on 27/10/21.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    var practiceFeedback: PracticeFeedback?

    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var practiceAgain: UIButton!
    @IBOutlet weak var goToDecks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedbackView.layer.cornerRadius = 16
        practiceAgain.layer.cornerRadius = 8
        goToDecks.layer.cornerRadius = 8
        
        feedbackLabel.text = "Parabéns! Você memorizou \(practiceFeedback!.remembered)/20"
    }
}
