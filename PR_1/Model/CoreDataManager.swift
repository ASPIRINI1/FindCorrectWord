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
    
    private init() { }
    
    
    //    MARK: - Managing words
    
    func addWord(engText: String, rusText:String) {
        
        let newWord = Word(context: context)
        newWord.eng = engText
        newWord.rus = rusText
        newWord.known = false
        newWord.rightSelection = 0
        
        saveChanges()
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    func deleteWord(objectID: NSManagedObjectID) {
        
        context.delete(context.object(with: objectID))
        saveChanges()
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    func setUnknown(id: NSManagedObjectID) {

        guard let request = context.object(with: id) as? Word else { return }
        request.known = false
        saveChanges()
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    func setWordRigthSelection(objectID: NSManagedObjectID) {
        
        guard let word = context.object(with: objectID) as? Word else { return }
        word.rightSelection += 1
        
        if word.rightSelection >= 3 {
            word.known = true
            NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
        }
        
        saveChanges()
    }
    
    func setDefault() {
        
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        guard let request = try? context.fetch(fetchRequest) else { print("Error getting words"); return }
        
        for word in request {
            word.known = false
            word.rightSelection = 0
        }
        
        saveChanges()
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    
    //    MARK: - Get words

    func getKnownWords(offset: Int) -> Word? {

        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let request = try? context.fetch(fetchRequest).first else { print("No known words found."); return nil }
        
        return request
    }
    
    func countOfknownWords() -> Int {
        
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let count = try? context.count(for: fetchRequest) else { print("Getting count error "); return 0 }
        
        return count
    }
    
    func getNewWords(offset: Int) -> Word? {
        
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known = %@", "false")
        guard let request = try? context.fetch(fetchRequest).first else { print("Error getting words"); return nil }
    
        return request
    }
    
    func countOfNewWords() -> Int {
        
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        fetchRequest.fetchLimit = 15
        fetchRequest.predicate = NSPredicate(format: "known = %@", "false")
        guard let count = try? context.count(for: fetchRequest) else { print("Getting count error "); return 0 }
        
        return count
    }
    
    func getAllWords(offset: Int) -> Word? {
        
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        fetchRequest.fetchOffset = offset
        guard let request = try? context.fetch(fetchRequest).first else { print("Error getting words"); return nil }
    
        return request
    }
    
    func countOfAllWords() -> Int {
        
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        guard let count = try? context.count(for: fetchRequest) else { print("Getting count error "); return 0 }
        
        return count
    }
    
//  MARK: - Additional funcs

    private func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Saving error: ", error)
        }
    }
    
    func addTenWords() {
        
        if countOfknownWords() + countOfNewWords() > 0 { return }
        
        let words = ["word" : "слово",
                     "sun" : "солнце",
                     "water" : "вода",
                     "weather" : "погода",
                     "car" : "машина",
                     "city" : "город",
                     "learn" : "учить",
                     "run" : "бежать",
                     "walk" : "прогулка",
                     "swim" : "плавать"]
        
        for word in words {
            addWord(engText: word.key, rusText: word.value)
        }
    }

}

