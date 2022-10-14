//
//  NewWordsTableViewCell.swift
//  PR_1
//
//  Created by Станислав Зверьков on 02.02.2022.
//

import UIKit
import CoreData

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    var objectID: NSManagedObjectID!
    
    func fill(word: Word) {
        engLabel.text = word.eng
        rusLabel.text = word.rus
        objectID = word.objectID
    }
    
    func fill(eng: String, rus: String, id: NSManagedObjectID) {
        engLabel.text = eng
        rusLabel.text = rus
        objectID = id
    }
    
    func setCellColor(color:UIColor,completion: @escaping()->()) {
        self.backgroundColor = color
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.backgroundColor = .white
            self.isSelected = false
            completion()
        }
    }
}
