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
        deckProgressLabel.text = "12/20"
        
        deckProgressCircleView.setValue(value: 0.7)
        deckProgressCircleView.trackColor = UIColor.gray
        deckProgressCircleView.progressColor = UIColor.black
        
    }
    
}
