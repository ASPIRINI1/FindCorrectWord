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
    
    let coreData = CoreDataManager()
    
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
        return coreData.getKnownWordsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordsCell", for: indexPath) as! KnownWrodsTableViewCell
        
        if coreData.getAllWords()[indexPath.row].known == true{
        cell.rusLabel.text = coreData.getAllWords()[indexPath.row].rus
        cell.engLabel.text = coreData.getAllWords()[indexPath.row].eng
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
//            coreData.deleteItem(item: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    //MARK: Delagate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}