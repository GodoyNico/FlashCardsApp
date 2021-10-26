import UIKit

class MyDecksCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var firstDeckView: UIView!
    @IBOutlet weak var firstTitleDeckLabel: UILabel!
    
    @IBOutlet weak var lastDeckView: UIView!
    @IBOutlet weak var lastTitleDeckLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(first: Deck?, last: Deck?) {
        
        guard let firstDeck = first else { return }
        firstDeckView.backgroundColor = .gray
        firstDeckView.layer.cornerRadius = 15
        firstTitleDeckLabel.text = firstDeck.title
        
        if let lastDeck = last {
            lastDeckView.backgroundColor = .gray
            lastDeckView.layer.cornerRadius = 15
            lastTitleDeckLabel.text = lastDeck.title
        }
        else {
            lastDeckView.backgroundColor = .none
            lastTitleDeckLabel.text = ""
        }
        
    }
    
}
