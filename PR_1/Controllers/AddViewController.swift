//
//  AddWordVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func AddViewControllerWordAdded(_ vc: AddViewController)
}

class AddViewController: UIViewController {

    @IBOutlet weak var engTextField: UITextField!
    @IBOutlet weak var rusTextField: UITextField!
    
    let manager = CoreDataManager.shared
    weak var delegate: AddViewControllerDelegate?
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        guard let engText = engTextField.text else { return }
        guard let rusText = rusTextField.text else { return }
        if isWordsValid(eng: engText, rus: rusText) {
            manager.addWord(eng: engText, rus: rusText)
            delegate?.AddViewControllerWordAdded(self)
            self.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Word not added", message: "Error in words.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    func isWordsValid(eng: String, rus: String) -> Bool {
        let rusRegex = try? NSRegularExpression(pattern: "[а-яА-Я]", options: .caseInsensitive)
        let engRegex = try? NSRegularExpression(pattern: "[a-zA-Z]", options: .caseInsensitive)
        if rusRegex?.firstMatch(in: rus, range: NSRange(location: 0, length: rus.count)) == nil { return false }
        if engRegex?.firstMatch(in: eng, range: NSRange(location: 0, length: eng.count)) == nil { return false }
        return true
    }
}
