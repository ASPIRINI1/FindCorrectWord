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
        newWord.rightSelection = 0
        saveChanges()
    }
    
    func deleteWord(words: Word) {
        context.delete(words)
        
        saveChanges()
    }
    
    func setKnown(id: NSManagedObjectID) {
        
        guard let request = context.object(with: id) as? Word else { return }
        request.known = true
        saveChanges()
    }
    
    func setDefault() {
        
        guard let request = try? context.fetch(fetchRequest) else { print("Error getting words"); return }
        
        for word in request {
            word.known = false
            word.rightSelection = 0
        }
        
        saveChanges()
    }
    
    
    //    MARK: - Known/UnKnown words

    func getKnownWords(offset: Int) -> Word? {

        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let request = try? context.fetch(fetchRequest).first else { print("Error getting words"); return Word() }
        return request
    }
    
    func countOfknownWords() -> Int {
        
        guard let count = try? context.count(for: fetchRequest) else { print("Getting count error "); return 0 }
        return count
    }
    
    func getUnknownWords(offset: Int) -> Word? {

        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let request = try? context.fetch(fetchRequest).first else { print("Error getting words"); return Word() }
        return request
    }
    
    func countOfUnknownWords() -> Int {
        
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

}

