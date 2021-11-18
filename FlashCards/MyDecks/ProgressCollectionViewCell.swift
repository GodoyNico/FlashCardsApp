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
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var yourProgressLabel: UILabel!
    @IBOutlet weak var keepPracticingLabel: UILabel!
    @IBOutlet weak var keepPracticingText: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        yourProgressView.layer.cornerRadius = 16
        yourProgressView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)
        
        viewBackground.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.color1Primary)
        
        yourProgressLabel.text = NSLocalizedString("your_progress", comment: "")
        keepPracticingText.text = NSLocalizedString("keep_practicing", comment: "")
        
        yourProgressLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.tabBarTint)
        keepPracticingLabel.textColor = UIColor(designSystem: DesignSystem.AssetsColor.tabBarTint)
        progressLabel.textColor = UIColor.white
        
        progressView.layer.cornerRadius = 6
        progressView.tintColor = UIColor(designSystem: DesignSystem.AssetsColor.color2Secondary)
        progressView.trackTintColor = UIColor.white
        
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
            
            let progress : Float = Float(progress_counter)/Float(totalCards > 0 ? totalCards : 1)
            progressView.progress = progress
            progressLabel.text = "\(Int(progress*100))%"
           
        } catch { }
    }
}
