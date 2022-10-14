//
//  WordsTableViewCell.swift
//  PR_1
//
//  Created by Станислав Зверьков on 13.10.2022.
//

import UIKit
import CoreData

class WordsTableViewCell: UITableViewCell {

    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    var objectID: NSManagedObjectID!
    
    func fill(word: Word) {
        engLabel.text = word.eng
        rusLabel.text = word.rus
        objectID = word.objectID
    }
}
