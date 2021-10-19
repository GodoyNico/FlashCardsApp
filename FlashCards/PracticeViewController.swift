//
//  PracticeViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 19/10/21.
//

import UIKit

class PracticeViewController: UIViewController {

    @IBOutlet weak var numberOfCards: UILabel!
    @IBOutlet weak var cardSide: UILabel!
    
    var practiceData: PracticeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfCards.text = "\(practiceData?.countCards)"
        cardSide.text = "\(practiceData?.isFront)"
        
    }

}
