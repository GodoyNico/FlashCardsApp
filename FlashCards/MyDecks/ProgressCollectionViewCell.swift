//
//  ProgressCollectionViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 05/11/21.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var yourProgressView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        
        yourProgressView.layer.cornerRadius = 6
        
        var myDecks: [Deck]
        do {
            myDecks = try context.fetch(Deck.fetchRequest())
            var totalCards = 0;
            var progress_counter = 0;
            
            for deck in myDecks {
                
                if let listCards = deck.cards {
                    totalCards += listCards.count
                }
                
                progress_counter += Int(deck.progress_counter)
            }
            
            let progress : Float = Float(progress_counter)/Float(totalCards)
            progressView.progress = progress
            progressLabel.text = "\(Int(progress*100))%"
            
        } catch { }
        
    }
}
