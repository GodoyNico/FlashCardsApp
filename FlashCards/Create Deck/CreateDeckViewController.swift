//
//  CreateDeckViewController.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 26/10/21.
//

import UIKit

class CreateDeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var deck: Deck?
    var cards: [Card] = []
    
    let deckNameCell: String = "NewDeckCell"
    let newCardCell: String = "NewCardCell"
    let switchCell: String = "switchCell"
    
    @IBOutlet weak var createDeckTableView: UITableView!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deck = Deck(context: self.context)
        
        createDeckTableView.delegate = self
        createDeckTableView.dataSource = self
                
    }
    
    @IBAction func deckDone(_ sender: Any) {
        
        // Save the Data
        do {
            try self.context.save()
        } catch { }
                
        self.dismiss(animated: true, completion: nil)
        
    }
    
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
            
             return switchCell
        }
        
    }
}
