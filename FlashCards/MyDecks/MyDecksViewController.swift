import UIKit

class MyDecksViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let myDecksCellID: String = "myDecksCell"
    static let titlemyDecksCellID: String = "titleMyDecksCell"
    static let progressCellID: String = "progressCellID"
    static let searchDecksCellID: String = "searchDecksCellID"
    static let emptyStateMyDecksCellID: String = "EmptyStateMyDecksCell"
    
    let deckSegueId: String = "GoToSingleDeck"
    var myDecks: [Deck] = []
    var realData: [Deck] = []
    
    @IBOutlet weak var myDecksCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        configureNavBar()
        
        myDecksCollectionView.dataSource = self
        myDecksCollectionView.delegate = self
        
        fetchDecks()
        
        self.myDecksCollectionView.contentInset.bottom += 100
        self.hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDecks()
    }
    
    func configureNavBar() {
        let image = UIImage(named: "winnieCard")
        let imageView = UIImageView(image: image)
        imageView.frame.size.width = 250
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.width) - 40 * 2, height: 65))
        view.addSubview(imageView)
        imageView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = view
    }
    
    func fetchDecks() {
        do {
            self.realData = try context.fetch(Deck.fetchRequest())
            self.myDecks = self.realData
            DispatchQueue.main.async {
                self.myDecksCollectionView.reloadData()
            }
        } catch { }
    }
    
    func viewConfig() {
        view.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
        
        myDecksCollectionView.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
    }
}

extension MyDecksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 3 && myDecks.count > 0 ? myDecks.count : 1
    }
    
    // MARK: List MyDecks
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.progressCellID, for: indexPath) as! ProgressCollectionViewCell
            
            cell.configure()
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.searchDecksCellID, for: indexPath) as! SearchCollectionViewCell
            
            cell.configure()
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.titlemyDecksCellID, for: indexPath) as! TitleMyDecksCollectionViewCell
            
            cell.myDecksTitleLabel.text = "My Decks"
            cell.configure()
            
            return cell
            
        } else {
                
            if myDecks.count > 0 {

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.myDecksCellID, for: indexPath) as! MyDecksCollectionViewCell
                
                cell.configure(deck: myDecks[indexPath.row])
                
                return cell
                
            } else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.emptyStateMyDecksCellID, for: indexPath) as! EmptyStateMyDecksCollectionViewCell
                
                cell.configure()
                
                return cell
            }
            
        }
        
    }
    
    // MARK: Go To Deck Details
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 && myDecks.count > 0 {
            performSegue(withIdentifier: self.deckSegueId, sender: myDecks[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let singleDeckViewController = segue.destination as? SingleDeckViewController, let deck = sender as? Deck else { return }
        
        singleDeckViewController.configure(deck: deck)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        if indexPath.section != 3 || myDecks.count == 0 {
            return nil
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menuElement in
            
            return UIMenu(
                image: nil,
                identifier: nil,
                options: UIMenu.Options.destructive,
                children: [ UIAction(title: NSLocalizedString("delete", comment: ""), image: UIImage(systemName: "trash"), attributes: .destructive,handler: { action in
                    
                    let alert = UIAlertController(title: nil, message: NSLocalizedString("delete_deck_message", comment: ""), preferredStyle: .alert)
                    
                    let deleteButton = UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .default) { (action) in
                        
                        // Which Deck to Remove
                        let deckToRemove = self.myDecks[indexPath.row]
                        
                        // Remove the Deck
                        self.context.delete(deckToRemove)
                        
                        // Save the Data
                        do {
                            try self.context.save()
                        } catch { }
                        
                        // Re-Fetch the Data
                        self.fetchDecks()
                        
                    }
                    
                    let cancelButton = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive) { (action) in
                        return
                    }
                    
                    alert.addAction(cancelButton)
                    alert.addAction(deleteButton)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                })])
            
        }
        
    }
    
}

extension MyDecksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 32.0
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 92)
        }else if indexPath.section == 1 {
            return CGSize(width: width+16, height: 36)
        } else if indexPath.section == 2 {
            return CGSize(width: width, height: 39)
        } else {
            if myDecks.count > 0 {
                return CGSize(width: (width-12)/2, height: 197)
            } else {
                return CGSize(width: width, height: 460)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
    }
    
}

extension MyDecksViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.myDecks.removeAll()
        
        for item in self.realData {
            
            guard let title = item.title else {
                continue
            }
            
            if title.lowercased().contains(searchBar.text!.lowercased()) {
                self.myDecks.append(item)
            }
        }
        
        if (searchBar.text!.isEmpty) {
            self.myDecks = self.realData
        }
        
        self.myDecksCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.myDecks.removeAll()
        
        for item in self.realData {
            
            guard let title = item.title else {
                continue
            }
            
            if title.lowercased().contains(searchBar.text!.lowercased()) {
                self.myDecks.append(item)
            }
        }
        
        if (searchBar.text!.isEmpty) {
            self.myDecks = self.realData
        }
        
        myDecksCollectionView.reloadSections(IndexSet(integer: 3))
        
    }
    
}
