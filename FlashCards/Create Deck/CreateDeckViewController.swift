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
    
    var keybordIsOpen = false
    
    @IBOutlet weak var createDeckTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        
        if self.deck == nil {
            self.deck = Deck(context: self.context)
            self.screen = .create
        }
        
        switch screen {
        case .create:
            navigationItem.title = NSLocalizedString("create_deck", comment: "")
            self.deck?.isFront = true
        case .edit:
            navigationItem.title = NSLocalizedString("edit_deck", comment: "")
        case .addCard:
            navigationItem.title = NSLocalizedString("add_card", comment: "")
        default:
            navigationItem.title = NSLocalizedString("create_deck", comment: "")
        }
        
        createDeckTableView.delegate = self
        createDeckTableView.dataSource = self

        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardApear() {
        if !keybordIsOpen {
            self.createDeckTableView.contentInset.bottom += 250
            self.createDeckTableView.verticalScrollIndicatorInsets.bottom += 250
            keybordIsOpen = true
        }
    }
    
    @objc func keyboardDisapear() {
        if keybordIsOpen {
            self.createDeckTableView.contentInset.bottom -= 250
            self.createDeckTableView.verticalScrollIndicatorInsets.bottom -= 250
            keybordIsOpen = false
        }
    }

    
    func configure(deck: Deck?, screen: Screen) {
        self.deck = deck
        self.screen = screen
    }
    
    @IBAction func cancel(_ sender: Any) {
        context.rollback()

        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deckDone(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("deck_title_message", comment: ""), preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .default) { (action) in
            return
        }
        
        alert.addAction(okButton)
        
        if let currentDeck = deck, let currentDeckTitle = currentDeck.title {
            
            if currentDeckTitle.isEmpty {
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                do {
                    try self.context.save()
                } catch { }
                navigationController?.popViewController(animated: true)
            }
            
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func viewConfig() {
        view.backgroundColor = UIColor(designSystem: DesignSystem.AssetsColor.background)
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
            newCardCell.delegate = self
            newCardCell.delegateImage = self
            
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
                newCardCell.delegateImage = self
                
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
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("delete_card_message", comment: ""), preferredStyle: .alert)
        
        let deleteButton = UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .default) { (action) in
            
            //Card to remove
            self.context.delete(card)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            // Re-Fetch the Data
            self.createDeckTableView.reloadData()
            
        }
        
        let cancelButton = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive) { (action) in
            return
        }
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateDeckViewController: DeleteDeckDelegate {
    
    func didTapDeleteButton(fromCell cell: UITableViewCell) {
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("delete_deck_message", comment: ""), preferredStyle: .alert)
        
        let deleteButton = UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .default) { (action) in
            
            guard let deckToRemove = self.deck else { return }
            
            // Remove the Deck
            self.context.delete(deckToRemove)
            
            // Save the Data
            do {
                try self.context.save()
            } catch { }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        let cancelButton = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive) { (action) in
            return
        }
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CreateDeckViewController: AddCardImageDelegate {
        
    func selectImage(completion: @escaping (UIImage?) -> Void) {
        EscolherImagem().selecionadorImagem(self) { imagem in
            completion(imagem)
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
