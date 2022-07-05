//
//  CoreDataManager.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    private var model = [Words]()
    
    private init() {
    }
    
    
    //    MARK: - Managing words
    
    func addWord(engText: String, rusText:String) {
        
        let newWord = Words(context: context)
        newWord.eng = engText
        newWord.rus = rusText
        
        saveChanges()
    }
    
    func deleteWord(words: Words) {
        context.delete(words)
        
        saveChanges()
    }
    
    //    MARK: - Known/UnKnown words

//    func getKnownWords() -> [Words] {
//        
//    }
//
//    func getUnKnownWords() -> [Words] {
//        var words = [Words]()
//        for word in model {
//            if word.known == false {
//                words.append(word)
//            }
//        }
//        return words
//    }
//
//    func setKnown(engWord: String, known: Bool) {
//        for word in model {
//            if word.eng == engWord{
//                word.known = known
//            }
//        }
//        saveChanges()
//        getAllItems()
//    }
//
////    MARK: - Additional funcs
//
//    func setDefault() {
//        for model in model {
//            model.known = false
//            model.rightSelection = 0
//        }
//       saveChanges()
//    }
//
    private func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Saving error: ", error)
        }
    }

}

