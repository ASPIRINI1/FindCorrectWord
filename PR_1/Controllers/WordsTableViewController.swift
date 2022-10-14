//
//  WordsTableTableVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 08.07.2022.
//

import UIKit

class WordsTableViewController: UITableViewController {
    
    let manager = CoreDataManager.shared
    
    @IBAction func setDefault(_ sender: Any) {
        manager.setDefault()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddViewController {
            guard let addVC = segue.destination as? AddViewController else { return }
            addVC.delegate = self
        }
    }
}

//MARK: - UITableViewDataSource

extension WordsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.countOfAllWords()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WordsTableViewCell", for: indexPath) as? WordsTableViewCell {
            guard let word = manager.getAllWords(offset: indexPath.row) else { return cell }
            cell.fill(word: word)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? WordsTableViewCell else { return }
        if editingStyle == .delete {
            guard let objectID = selectedCell.objectID else { return }
            manager.deleteWord(id: objectID)
            tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelagate

extension WordsTableViewController {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension WordsTableViewController: AddViewControllerDelegate {
    func AddViewControllerWordAdded(_ vc: AddViewController) {
        tableView.reloadData()
    }
}
