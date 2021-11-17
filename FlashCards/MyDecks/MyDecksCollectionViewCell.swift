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
        deckDeckView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Primary)
        deckDeckView.layer.cornerRadius = 15
        
        
        
        deckTitleDeckLabel.text = deck.title
        deckTitleDeckLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Quaternary)
        
        deckProgressCircleView.trackColor = UIColor.white
        deckProgressCircleView.progressColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Quaternary) ?? .white
        
        deckProgressLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Quaternary)
        
        if let cardsList = deck.cards {
            deckProgressLabel.text = "\(deck.progress_counter)/\(cardsList.count)"
            deckProgressCircleView.setValue(value: Double(deck.progress_counter)/Double(cardsList.count))
        } else {
            deckProgressCircleView.setValue(value: 0)
        }
    }
    
}
