//
//  WordsTableTableVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 08.07.2022.
//

import UIKit

class WordsTableTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Update"), object: nil, queue: nil) { _ in
            self.tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func setDefault(_ sender: Any) {
        CoreDataManager.shared.setDefault()
    }
    
//MARK: - DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.countOfAllWords()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsTableCell", for: indexPath) as! WordSTableTableViewCell
        guard let word = CoreDataManager.shared.getAllWords(offset: indexPath.row) else { return cell }
        
        cell.engLabel.text = word.eng
        cell.rusLabel.text = word.rus
        cell.objectID = word.objectID
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! WordSTableTableViewCell
        if editingStyle == .delete {
            CoreDataManager.shared.deleteWord(objectID: selectedCell.objectID)
            tableView.reloadData()
        }
    }
    
//MARK: - Delagate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
