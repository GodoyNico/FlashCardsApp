import UIKit

class MyDecksViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let myDecksCellID: String = "myDecksCell"
    static let titlemyDecksCellID: String = "titleMyDecksCell"
    let deckSegueId: String = "GoToSingleDeck"

    var myDecks: [Deck] = []
    
    @IBOutlet weak var myDecksCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDecksCollectionView.dataSource = self
        myDecksCollectionView.delegate = self
        
        fetchDecks()
        
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return myDecks.count
    }
    
    // MARK: List MyDecks
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
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

        singleDeckViewController.deck = deck
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menuElement in
            return UIMenu(image: nil, identifier: nil, options: UIMenu.Options.destructive, children: [UIAction(title:"delete", attributes: .destructive ,handler: { action in
                print("deu certo")
            })])
        }
    }

}

extension MyDecksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (UIScreen.main.bounds.width-44)/2

        if indexPath.section == 0 {
            return CGSize(width: width, height: 44)
        }

        return CGSize(width: width, height: 197)
        // largura da tela (358) - 44 (bordas (16+16) + meio (+12) == 44)
        // 358 - 44 = 314/2 == 157
        // 157/358 = 0.4385
        // UIScreen.main.bounds.width * 0.4385
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }

        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)

    }
    
}
