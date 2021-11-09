//
//  EditDeckViewController.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 09/11/21.
//

import UIKit

class EditDeckViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var deck: Deck?
    
    let deckNameCell: String = "NewDeckCell"
    let newCardCell: String = "NewCardCell"
    let switchCell: String = "switchCell"
    
    @IBOutlet weak var editDeckTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editDeckTableView.delegate = self
        editDeckTableView.dataSource = self
    }
    
    @IBAction func deckDone(_ sender: Any) {
        
        do {
            try self.context.save()
        } catch { }
                
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func configure(deck: Deck?) {
        self.deck = deck
    }
    
}

extension EditDeckViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let deckNameCell = editDeckTableView.dequeueReusableCell(withIdentifier: deckNameCell ) as! NewDeckTableViewCell
                        
            deckNameCell.configure(newDeck: self.deck)
            
            return deckNameCell
            
        } else if indexPath.row == 1 {
            
            let newCardCell = editDeckTableView.dequeueReusableCell(withIdentifier: newCardCell ) as! NewCardTableViewCell
            
            newCardCell.configure(newDeck: self.deck)
            
            return newCardCell
            
        } else {
            
            let switchCell = editDeckTableView.dequeueReusableCell(withIdentifier: switchCell) as! SwitchTableViewCell
            
             return switchCell
        }
        
    }
    
}

