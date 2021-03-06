//
//  NewCardTableViewCell.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 28/10/21.
//

import UIKit

protocol DeleteCardDelegate: AnyObject {
    
    func didTapDeleteAlert(fromCell cell: UITableViewCell, card: Card)
    
}

class NewCardTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let collectionCellID = "cardCollectionCell"
    let emptyStateCell: String = "emptyStateCell"

    var deck: Deck?
    var cards: [Card] = []
    
    weak var delegate: DeleteCardDelegate?
    weak var delegateImage: AddCardImageDelegate?
        
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var cardCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        
        setupLayout()
        
    }
    
    func setupLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(610))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        cardCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func addCard(_ sender: Any) {
        
        let newCard = Card(context: self.context)
        newCard.deck = self.deck
        
        let fContent = Content(context: self.context)
        fContent.text = ""
        
        let vContent = Content(context: self.context)
        vContent.text = ""
        
        newCard.front_content = fContent
        newCard.back_content = vContent
        
        cards.append(newCard)
        
        //fetchData()
        cardCollectionView.reloadData()
        numberOfCardsLabel.text = String("\(cards.count) cards")
    }
    
    func configure(newDeck: Deck?) {
        viewBackground.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        // TODO: - Ajustar tradu????o do bot??o
        addCardButton.titleLabel?.text = NSLocalizedString("add_card", comment: "")
        
        self.deck = newDeck
        fetchData()
        numberOfCardsLabel.text = String("\(cards.count) cards")
    }
    
    func fetchData() {
        self.cards = deck?.cards?.allObjects as? [Card] ?? []

        DispatchQueue.main.async {
            self.cardCollectionView.reloadData()
        }
    }
}

extension NewCardTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count > 0 ? cards.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if cards.count > 0 {
            let cardCollectionCell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! CardCollectionViewCell
            
            cardCollectionCell.configure(card: cards[indexPath.row])
            cardCollectionCell.delegate = self
            
            return cardCollectionCell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.emptyStateCell, for: indexPath) as! EmptyStateCreateDeckCollectionViewCell
            
            cell.configure()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        if cards.count > 0 {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menuElement in

                return UIMenu(
                    image: nil,
                    identifier: nil,
                    options: UIMenu.Options.destructive,
                    children: [ UIAction(title: NSLocalizedString("delete", comment: ""), image: UIImage(systemName: "trash"), attributes: .destructive, handler: { action in

                        self.delegate?.didTapDeleteAlert(fromCell: self, card: self.cards[indexPath.row])
                        
                    })])
            }
        }
        return nil
    }
}

extension NewCardTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.9, height: 620)
    }
}

extension NewCardTableViewCell: AddCardImageDelegate {
    
    func selectImage(completion: @escaping (UIImage?) -> Void) {
        delegateImage?.selectImage(completion: completion)
    }
    
}
