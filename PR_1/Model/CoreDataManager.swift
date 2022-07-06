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
    private let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
    
    private init() {
    }
    
    
    //    MARK: - Managing words
    
    func addWord(engText: String, rusText:String) {
        
        let newWord = Word(context: context)
        newWord.eng = engText
        newWord.rus = rusText
        newWord.known = true
        saveChanges()
    }
    
    func deleteWord(words: Word) {
        context.delete(words)
        
        saveChanges()
    }
    
    func setKnown(id: NSManagedObjectID) {
        
        guard let request = try? context.object(with: id) as? Word else { return }
        request.known = true
    }
    
    
    //    MARK: - Known/UnKnown words

    func getKnownWords(offset: Int) -> [Word] {

        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let request = try? context.fetch(fetchRequest) else { print("Error getting words"); return [] }
        return request
    }
    
    func countOfknownWords() -> Int {
        
        guard let count = try? context.count(for: fetchRequest) else { print("Getting count error "); return 0 }
        return count
    }
    
    func getUnknownWords(offset: Int) -> [Word] {

        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let request = try? context.fetch(fetchRequest) else { print("Error getting words"); return [] }
        return request
    }
    
    func countOfUnknownWords() -> Int {
        
        guard let count = try? context.count(for: fetchRequest) else { print("Getting count error "); return 0 }
        return count
    }
    
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

