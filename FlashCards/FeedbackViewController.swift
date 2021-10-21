//
//  FeedbackViewController.swift
//  FlashCards
//
//  Created by Nicolas Godoy on 21/10/21.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    var practiceFeedback: PracticeFeedback?

    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedbackLabel.text = "Você acertou: \(practiceFeedback!.remembered) e errou: \(practiceFeedback!.noRemembered)"
    }
}
