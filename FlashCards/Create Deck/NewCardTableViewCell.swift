//
//  NewCardTableViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

class NewCardTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var addCardButton: UIButton!
    
    let collectionCellID = "cardCollectionCell"
    var cards: [Card] = []
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    @IBAction func createCard(_ sender: Any) {
        
        let newCard = Card(context: self.context)
        newCard.id = UUID()
        //        newCard.front_content?.text =
        //        newCard.back_content?.text =
        //        newCard.front_content?.image =
        //        newCard.back_content?.image =
        
        // Save the Data
        do {
            try self.context.save()
        } catch { }
    }
    
    @IBOutlet weak var deckImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        
    }
    
    func countCards() -> Int {
        let numberOfCards = cards.count
        numberOfCardsLabel.text = "\(numberOfCards) cards"
        return numberOfCards
    }
}

extension NewCardTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cardCollectionCell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! cardCollectionViewCell
        
        return cardCollectionCell
    }
}
