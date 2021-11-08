import UIKit

class MyDecksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckDeckView: UIView!
    @IBOutlet weak var deckTitleDeckLabel: UILabel!
    @IBOutlet weak var deckProgressCircleView: CircularProgressView!
    @IBOutlet weak var deckProgressLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(deck: Deck) {
        deckDeckView.backgroundColor = UIColor(named: "gray1")
        deckDeckView.layer.cornerRadius = 15
        deckTitleDeckLabel.text = deck.title
        
        if let cardsList = deck.cards {
            deckProgressLabel.text = "\(deck.progress_counter)/\(cardsList.count)"
            deckProgressCircleView.setValue(value: Double(deck.progress_counter)/Double(cardsList.count))
        } else {
            deckProgressCircleView.setValue(value: 0)
        }
       
        deckProgressCircleView.trackColor = UIColor.gray
        deckProgressCircleView.progressColor = UIColor.black
        
    }
    
}
