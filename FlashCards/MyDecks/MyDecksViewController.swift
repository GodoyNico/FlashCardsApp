import UIKit

class MyDecksViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let myDecksCellID: String = "myDecksCell"
    static let titlemyDecksCellID: String = "titleMyDecksCell"

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
        
        let countCells: Int = Int(round(Double(myDecks.count)/2.0))
        return countCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.titlemyDecksCellID, for: indexPath) as! TitleMyDecksCollectionViewCell

            cell.myDecksTitleLabel.text = "My Decks"
            
            return cell
            
        } else {
            
            let offset: Int = indexPath.row * 2
            let first: Deck? = myDecks[offset]
            let last: Deck? = (offset + 1) < myDecks.count ? myDecks[offset+1] : nil
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.myDecksCellID, for: indexPath) as! MyDecksCollectionViewCell
            
            cell.configure(first: first, last: last)
            
            return cell
        }
        
    }
    
}

extension MyDecksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section != 0 {
            let ratio = 161.0/197.0
            let width = collectionView.bounds.width
            return CGSize(width: width, height: width*ratio)
        }
        
        return UICollectionViewFlowLayout.automaticSize
        
    }
}
