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
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var feedbackText: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deckNameLabel: UILabel!
    @IBOutlet weak var practiceAgain: UIButton!
    @IBOutlet weak var goToDecks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        if practiceFeedback?.remembered == 0 {
            feedbackLabel.text = NSLocalizedString("no_remembered", comment: "")
            feedbackText.text = NSLocalizedString("bad_feedback", comment: "")
        } else {
        feedbackLabel.text = NSLocalizedString("congrats", comment: "")
        feedbackText.text = NSLocalizedString("good_feedback", comment: "")
        }
        
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
    
    func configView() {
        view.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
        contentView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
        
        feedbackLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Secondary)
        feedbackText.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Secondary)
        counterLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Secondary)
        deckNameLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.basicQuaternary)
        
        practiceAgain.layer.cornerRadius = 8
        practiceAgain.layer.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)?.cgColor
        practiceAgain.tintColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
        
        goToDecks.layer.cornerRadius = 8
        goToDecks.tintColor = UIColor(designSystem: DesignSystem.AssetsColor.basicQuaternary2)
    }
}
