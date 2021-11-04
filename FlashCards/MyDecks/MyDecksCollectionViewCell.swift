import UIKit

class MyDecksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckDeckView: UIView!
    @IBOutlet weak var deckTitleDeckLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(deck: Deck) {
        deckDeckView.backgroundColor = UIColor(named: "gray1")
        deckDeckView.layer.cornerRadius = 15
        deckTitleDeckLabel.text = deck.title
    }
    
}
