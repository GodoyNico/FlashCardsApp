//
//  ProgressCollectionViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 05/11/21.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var progressView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        progressView.layer.cornerRadius = 6
    }
}
