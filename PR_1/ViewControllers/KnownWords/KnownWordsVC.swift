//
//  KnownWordsViewController.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit
import CoreData

class KnownWordsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


//MARK: - UItableView Delagate & DataSource

extension KnownWordsVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.countOfknownWords()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KnownWordsCell", for: indexPath) as! KnownWrodsTableViewCell
        guard let word = CoreDataManager.shared.getKnownWords(offset: indexPath.row) else { return cell }
        
        cell.engLabel.text = word.eng
        cell.rusLabel.text = word.rus
        cell.objectID = word.objectID
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! KnownWrodsTableViewCell
        if editingStyle == .delete{
            CoreDataManager.shared.deleteWord(objectID: selectedCell.objectID)
            tableView.reloadData()
        }
    }
    
    
    //MARK: Delagate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
