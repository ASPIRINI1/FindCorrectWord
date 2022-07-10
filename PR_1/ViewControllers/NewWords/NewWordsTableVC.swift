//
//  NewWordsTableVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 08.07.2022.
//

import UIKit

class NewWordsTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Update"), object: nil, queue: nil) { _ in
            self.tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func refreshNavBarButton(_ sender: Any) {
        tableView.reloadData()
    }

    
    //MARK: DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.countOfNewWords()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordsCell", for: indexPath) as! NewWordsTableViewCell
        guard let word = CoreDataManager.shared.getNewWords(offset: indexPath.row) else { return cell }
        
        if CoreDataManager.shared.countOfNewWords() > indexPath.row {
            cell.rusLabel.text = CoreDataManager.shared.getNewWords(offset: Int.random(in: 0...indexPath.row))?.rus
        } else {
            cell.rusLabel.text = word.rus
        }

        cell.engLabel.text = word.eng
        cell.objectID = word.objectID
        
        return cell
    }
    
    
    //MARK: Delegate
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? NewWordsTableViewCell else { return }
        guard let engCellText = selectedCell.engLabel.text else { return }
        guard let rusCellText = selectedCell.rusLabel.text else { return }
        guard let engWord = CoreDataManager.shared.getNewWords(offset: indexPath.row)?.eng else { return }
        guard let rusWord = CoreDataManager.shared.getNewWords(offset: indexPath.row)?.rus else { return }
        
        if engWord == engCellText && rusWord == rusCellText {
            selectedCell.setCellColor(color: .green) {
                CoreDataManager.shared.setWordRigthSelection(objectID: selectedCell.objectID)
                tableView.reloadData()
            }
        } else {
            selectedCell.setCellColor(color: .red) {
                tableView.reloadData()
                let alertController = UIAlertController(title: "Wrong!", message: "You chose the wrong word. Try again.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        selectedCell.backgroundColor = .white }))
                    self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

