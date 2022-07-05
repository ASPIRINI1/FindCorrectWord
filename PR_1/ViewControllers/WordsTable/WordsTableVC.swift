//
//  WordTableViewController.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit
import CoreData

class WordsTableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        coreData.getAllItems()
        tableView.reloadData()
    }
    
    @IBAction func setDefaults(_ sender: Any) {
//        coreData.setDefault()
//        coreData.getAllItems()
    }
    
}

//MARK: - UItableView Delagate & DataSource

extension WordsTableVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coreData.getAllWords().count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsTableCell", for: indexPath) as! WordSTableTableViewCell

//        cell.engLabel.text = coreData.getAllWords()[indexPath.row].eng
//        cell.rusLabel.text = coreData.getAllWords()[indexPath.row].rus
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
//            coreData.deleteItem(itemIndex: indexPath.row)
            tableView.reloadData()
        }
    }
    
    //MARK:  Delagate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
