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
    var cards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfCards.text = "\(practiceData?.countCards)"
        cardSide.text = "\(practiceData?.isFront)"
        
        generateCards()
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
                
        //teste
        for card in cards {
            print(card.front_content?.text)
        }
    }

}
