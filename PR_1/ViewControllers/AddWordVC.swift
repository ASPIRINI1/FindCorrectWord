//
//  AddWordVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit

class AddWordVC: UIViewController {

    @IBOutlet weak var engTextField: UITextField!
    @IBOutlet weak var rusTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        guard let engText = engTextField.text else { return }
        guard let rusText = rusTextField.text else { return }
        
        let rusCharacters = "йцукенгшщзхъфывапролджэёячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮ"
        let engCharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
        
        engTextField.text = engText.filter { engCharacters.contains($0) }
        rusTextField.text = rusText.filter { rusCharacters.contains($0) }
        
        if rusTextField.text != "" && engTextField.text != "" {
            
            CoreDataManager.shared.addWord(engText: engText, rusText: rusText)
            
            let successAletr = UIAlertController(title: "Success", message: "Word added.", preferredStyle: .alert)
            successAletr.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(successAletr, animated: true, completion: nil)
            
            engTextField.text = ""
            rusTextField.text = ""
            navigationController?.popViewController(animated: true)
            
        } else {
            let failAletr = UIAlertController(title: "Word not added", message: "Cant add word to dictionary.", preferredStyle: .alert)
            
            failAletr.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(failAletr, animated: true, completion: nil)
        }
    }
    
    
    
}
