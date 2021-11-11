import UIKit

enum Screen {
    case create, edit, addCard
}

class CreateDeckViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var deck: Deck?
    var cards: [Card] = []
    var screen: Screen?
    
    let deckNameCell: String = "NewDeckCell"
    let newCardCell: String = "NewCardCell"
    let switchCell: String = "switchCell"
    let deleteCell: String = "removeDeckCell"
    
    @IBOutlet weak var createDeckTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.deck == nil {
            self.deck = Deck(context: self.context)
            self.screen = .create
        }
        
        switch screen {
        case .create:
            navigationItem.title = "Create Deck"
            self.deck?.isFront = true
        case .edit:
            navigationItem.title = "Edit Deck"
        case .addCard:
            navigationItem.title = "Add Card"
        default:
            navigationItem.title = "Create Deck"
        }
        
        createDeckTableView.delegate = self
        createDeckTableView.dataSource = self
        
    }
    
    func configure(deck: Deck?, screen: Screen) {
        self.deck = deck
        self.screen = screen
    }
    
    @IBAction func cancel(_ sender: Any) {
        context.reset()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deckDone(_ sender: Any) {
        
        do {
            try self.context.save()
        } catch { }
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension CreateDeckViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch screen {
        case .create:
            return 3
        case .edit:
            return 4
        case .addCard:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if screen == .addCard {
            
            let newCardCell = createDeckTableView.dequeueReusableCell(withIdentifier: newCardCell ) as! NewCardTableViewCell
            
            newCardCell.configure(newDeck: self.deck)
            
            return newCardCell
            
        } else {
            
            if indexPath.row == 0 {
                
                let deckNameCell = createDeckTableView.dequeueReusableCell(withIdentifier: deckNameCell ) as! NewDeckTableViewCell
                
                deckNameCell.configure(newDeck: self.deck)
                
                return deckNameCell
                
            } else if indexPath.row == 1 {
                
                let newCardCell = createDeckTableView.dequeueReusableCell(withIdentifier: newCardCell ) as! NewCardTableViewCell
                
                newCardCell.configure(newDeck: self.deck)
                newCardCell.delegate = self
                
                return newCardCell
                
            } else if indexPath.row == 2 {
                
                let switchCell = createDeckTableView.dequeueReusableCell(withIdentifier: switchCell) as! SwitchTableViewCell
                
                switchCell.configure(newDeck: self.deck)
                
                return switchCell
                
            } else {
                
                let deleteCell = createDeckTableView.dequeueReusableCell(withIdentifier: deleteCell) as! DeleteDeckTableViewCell
                
                deleteCell.configure(deck: self.deck)
                deleteCell.delegate = self
                
                return deleteCell
                
            }
            
        }
    }
}

extension CreateDeckViewController: DeleteCardDelegate {
    
    func didTapDeleteAlert(fromCell cell: UITableViewCell, card: Card) {
        
        let alert = UIAlertController(title: nil, message: "Tem certeza que você quer deletar esse card? ", preferredStyle: .alert)
        
        let deleteButton = UIAlertAction(title: "Sim", style: .default) { (action) in
            
            //Card to remove
            self.context.delete(card)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.createDeckTableView.reloadData()
            
        }
        
        let cancelButton = UIAlertAction(title: "Não", style: .destructive) { (action) in
            return
        }
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateDeckViewController: DeleteDeckDelegate {
    
    func didTapDeleteButton(fromCell cell: UITableViewCell) {
        
        let alert = UIAlertController(title: nil, message: "Tem certeza que você quer deletar esse deck? ", preferredStyle: .alert)
        
        let deleteButton = UIAlertAction(title: "Sim", style: .destructive) { (action) in
            
            guard let deckToRemove = self.deck else { return }
            
            // Remove the Deck
            self.context.delete(deckToRemove)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        let cancelButton = UIAlertAction(title: "Não", style: .default) { (action) in
            return
        }
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

