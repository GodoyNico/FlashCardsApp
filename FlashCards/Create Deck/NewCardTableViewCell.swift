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
    
    @IBAction func addCard(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        
        numberOfCardsLabel.text = String("\(cards.count) cards")
    }
    
    func configure(newDeck: Deck?) {
        self.deck = newDeck
    }
}

extension NewCardTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cardCollectionCell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! cardCollectionViewCell
        
        return cardCollectionCell
    }
}

extension NewCardTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.8, height: 610)
    }
    
}
