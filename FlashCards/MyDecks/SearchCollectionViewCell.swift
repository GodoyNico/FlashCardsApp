//
//  SearchCollectionViewCell.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 05/11/21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        searchBar.barTintColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        searchBar.placeholder = NSLocalizedString("search_bar", comment: "")
    }
}
