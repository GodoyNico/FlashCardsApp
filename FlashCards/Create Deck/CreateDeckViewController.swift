import UIKit

class CreateDeckViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var deck: Deck?
    var cards: [Card] = []
    
    let deckNameCell: String = "NewDeckCell"
    let newCardCell: String = "NewCardCell"
    let switchCell: String = "switchCell"
    
    @IBOutlet weak var createDeckTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.deck == nil {
            self.deck = Deck(context: self.context)
            self.deck?.isFront = true
        }
        
        createDeckTableView.delegate = self
        createDeckTableView.dataSource = self
        
    }
    
    func configure(deck: Deck?) {
        self.deck = deck
    }
    
    @IBAction func cancel(_ sender: Any) {
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let deckNameCell = createDeckTableView.dequeueReusableCell(withIdentifier: deckNameCell ) as! NewDeckTableViewCell
            
            deckNameCell.configure(newDeck: self.deck)
            
            return deckNameCell
            
        } else if indexPath.row == 1 {
            
            let newCardCell = createDeckTableView.dequeueReusableCell(withIdentifier: newCardCell ) as! NewCardTableViewCell
            
            newCardCell.configure(newDeck: self.deck)
            
            return newCardCell
            
        } else {
            
            let switchCell = createDeckTableView.dequeueReusableCell(withIdentifier: switchCell) as! SwitchTableViewCell
            
            switchCell.configure(newDeck: self.deck)
            
            return switchCell
        }
        
    }
}
