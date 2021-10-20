//
//  PracticeViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 19/10/21.
//

import UIKit

class PracticeViewController: UIViewController {

    var practiceData: PracticeData?
    var cards: [Card] = []
    var currentCard: Int = 0
    var flipped: Bool = false
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rememberedButton: UIButton!
    
    var isFront = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rememberedButton.isHidden = true
        
        print("\(practiceData!.countCards)")
        print("\(practiceData!.isFront)")
        
        generateCards()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.flip(_:)))
        cardView.addGestureRecognizer(tap)
        
        toPractice()
    }
    
    @IBAction func nextCard(_ sender: Any) {
        if currentCard < cards.count-1 {
            currentCard += 1;
            toPractice()
        } else {
            print("finalizou")
        }
        
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
            flipped = true
        }
        
    }

}
