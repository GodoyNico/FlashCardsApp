import UIKit

class MyDecksViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let myDecksCellID: String = "myDecksCell"
    static let titlemyDecksCellID: String = "titleMyDecksCell"
    static let progressCellID: String = "progressCellID"
    static let searchDecksCellID: String = "searchDecksCellID"
    
    let deckSegueId: String = "GoToSingleDeck"
    var myDecks: [Deck] = []
    
    @IBOutlet weak var myDecksCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDecksCollectionView.dataSource = self
        myDecksCollectionView.delegate = self
        
        fetchDecks()
        
        // TODO: RETIRAR AO FIM DO PROJETO
        if myDecks.isEmpty {
            createFakeDecks()
        }
        
    }
    
    func fetchDecks() {
        do {
            self.myDecks = try context.fetch(Deck.fetchRequest())
            DispatchQueue.main.async {
                self.myDecksCollectionView.reloadData()
            }
        } catch { }
    }
    
    func createFakeDecks() {
        
        for i in 1...5 {
            let newDeck = Deck(context: self.context)
            newDeck.title = "Deck Matemática \(i)"
            newDeck.id = UUID()
            newDeck.created_date = Date.now
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
        }
        
        // Re-Fetch the Data
        self.fetchDecks()
        
    }
    
}

extension MyDecksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 3 ? myDecks.count : 1
    }
    
    // MARK: List MyDecks
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.progressCellID, for: indexPath) as! ProgressCollectionViewCell
            
            cell.configure()

            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.searchDecksCellID, for: indexPath) as! SearchCollectionViewCell

            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.titlemyDecksCellID, for: indexPath) as! TitleMyDecksCollectionViewCell

            cell.myDecksTitleLabel.text = "My Decks"
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.myDecksCellID, for: indexPath) as! MyDecksCollectionViewCell
            
            cell.configure(deck: myDecks[indexPath.row])
            
            return cell
            
        }
        
    }
    
    // MARK: Go To Deck Details
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: self.deckSegueId, sender: myDecks[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let singleDeckViewController = segue.destination as? SingleDeckViewController, let deck = sender as? Deck else { return }

        singleDeckViewController.configure(deck: deck)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menuElement in
            
            return UIMenu(
                image: nil,
                identifier: nil,
                options: UIMenu.Options.destructive,
                children: [ UIAction(title:"Apagar", image: UIImage(systemName: "trash"), attributes: .destructive,handler: { action in
                                    
                    let alert = UIAlertController(title: nil, message: "Tem certeza que você quer deletar esse deck? ", preferredStyle: .alert)
                    
                    let deleteButton = UIAlertAction(title: "Sim", style: .default) { (action) in
                        
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
                    
                    let cancelButton = UIAlertAction(title: "Não", style: .destructive) { (action) in
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
            return CGSize(width: (width-12)/2, height: 197)
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
    }
    
}
