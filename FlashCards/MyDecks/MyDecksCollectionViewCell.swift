import UIKit

class MyDecksCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var firstDeckView: UIView!
    @IBOutlet weak var firstTitleDeckLabel: UILabel!
    
    @IBOutlet weak var lastDeckView: UIView!
    @IBOutlet weak var lastTitleDeckLabel: UILabel!
    
    var clickFirst : (()->())?
    var clickLast  : (()->())?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func clickFirst(_ sender: UITapGestureRecognizer? = nil) {
        clickFirst?()
    }
    
    @objc func clickLast(_ sender: UITapGestureRecognizer? = nil) {
        clickLast?()
    }
    
    func configure(first: Deck?, last: Deck?) {
        
        guard let firstDeck = first else { return }
        firstDeckView.backgroundColor = UIColor(named: "gray1")
        firstDeckView.layer.cornerRadius = 15
        firstTitleDeckLabel.text = firstDeck.title
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickFirst(_:)))
        firstDeckView.addGestureRecognizer(tap)
        
        if let lastDeck = last {
            lastDeckView.backgroundColor = UIColor(named: "gray1")
            lastDeckView.layer.cornerRadius = 15
            lastTitleDeckLabel.text = lastDeck.title
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickLast(_:)))
            lastDeckView.addGestureRecognizer(tap)
        } else {
            lastDeckView.backgroundColor = .none
            lastTitleDeckLabel.text = ""
        }
        
    }
    
}
