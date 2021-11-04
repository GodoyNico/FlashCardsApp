//
//  NewCardTableViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

class NewCardTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let collectionCellID = "cardCollectionCell"
    var deck: Deck?
    var cards: [Card] = []
    
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
                
        numberOfCardsLabel.text = String("\(cards.count) cards")
        
    }
    
    @IBAction func addCard(_ sender: Any) {
        let newCard = Card(context: self.context)
        newCard.deck = self.deck
        
        let fContent = Content(context: self.context)
        fContent.text = "frente"
        
        let vContent = Content(context: self.context)
        vContent.text = "verso"
        
        newCard.front_content = fContent
        newCard.back_content = vContent
        
        cards.append(newCard)
        
        cardCollectionView.reloadData()
        numberOfCardsLabel.text = String("\(cards.count) cards")
    }
    
    func configure(newDeck: Deck?) {
        self.deck = newDeck
    }
    
}

extension NewCardTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deck!.cards!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cardCollectionCell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! cardCollectionViewCell
        
        cardCollectionCell.configure(card: cards[indexPath.row])
        return cardCollectionCell
    }
}

extension NewCardTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.8, height: 610)
    }
    
}
