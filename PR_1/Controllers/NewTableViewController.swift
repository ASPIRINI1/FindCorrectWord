//
//  NewWordsTableVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 08.07.2022.
//

import UIKit

class NewTableViewController: UITableViewController {
    
    let manager = CoreDataManager.shared
    
    @IBAction func refreshNavBarButton(_ sender: Any) {
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension NewTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.countOfNewWords()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordsCell", for: indexPath) as? NewTableViewCell {
            guard let word = manager.getNewWords(offset: indexPath.row) else { return cell }
            if manager.countOfNewWords() > indexPath.row {
                let rus = manager.getNewWords(offset: Int.random(in: 0...indexPath.row))?.rus ?? ""
                cell.fill(eng: word.eng, rus: rus, id: word.objectID)
                return cell
            }
            cell.fill(eng: word.eng, rus: word.rus, id: word.objectID)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - UITableViewDelegate

extension NewTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? NewTableViewCell else { return }
        guard let engCellText = selectedCell.engLabel.text else { return }
        guard let rusCellText = selectedCell.rusLabel.text else { return }
        guard let word = CoreDataManager.shared.getNewWords(offset: indexPath.row) else { return }
        
        if word.eng == engCellText && word.rus == rusCellText {
            selectedCell.setCellColor(color: .green) {
                guard let objectID = selectedCell.objectID else { return }
                CoreDataManager.shared.incrementRightSelection(id: objectID)
                tableView.reloadData()
            }
        } else {
            selectedCell.setCellColor(color: .red) { [weak self] in
                tableView.reloadData()
                let alertController = UIAlertController(title: "Wrong!", message: "You chose the wrong word. Try again.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        selectedCell.backgroundColor = .white
                    }))
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
