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
    
    override func viewWillAppear(_ animated: Bool) {
//        coreData.getAllItems()
        tableView.reloadData()
    }
    
    
}


//MARK: - UItableView Delagate & DataSource

extension KnownWordsVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coreData.getKnownWords().count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KnownWordsCell", for: indexPath) as! KnownWrodsTableViewCell
//            cell.rusLabel.text = coreData.getKnownWords()[indexPath.row].rus
//            cell.engLabel.text = coreData.getKnownWords()[indexPath.row].eng
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! KnownWrodsTableViewCell
        if editingStyle == .delete{
//            coreData.setKnown(engWord: selectedCell.engLabel.text ?? "nil", known: false)
            tableView.reloadData()
        }
    }
    
    
    //MARK: Delagate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
