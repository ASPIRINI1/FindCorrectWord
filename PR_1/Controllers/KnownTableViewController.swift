//
//  KnownWordsTableVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 08.07.2022.
//

import UIKit

class KnownTableViewController: UITableViewController {
    let manager = CoreDataManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension KnownTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.countOfknownWords()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "KnownTableViewCell", for: indexPath) as? KnownTableViewCell {
            guard let word = manager.getKnownWords(offset: indexPath.row) else { return cell }
            cell.fill(word: word)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? KnownTableViewCell else { return }
        if editingStyle == .delete {
            guard let objectID = selectedCell.objectID else { return }
            manager.setUnknown(id: objectID)
            tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelagate

extension KnownTableViewController {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
