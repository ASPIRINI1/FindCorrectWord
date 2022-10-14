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
    
    enum Entities: String {
        case Word = "Word"
    }
    
    enum Errors: String {
        case ErrorGettingWords = "Error getting Words"
        case NoWordsFound = "No words found"
        case ErrorGettingCount = "Error getting count"
    }
    
    //    MARK: - Managing words
    
    func addWord(eng: String, rus:String) {
        let newWord = Word(context: context)
        newWord.eng = eng
        newWord.rus = rus
        newWord.known = false
        newWord.rightSelection = 0
        saveChanges()
    }
    
    func deleteWord(id: NSManagedObjectID) {
        context.delete(context.object(with: id))
        saveChanges()
    }
    
    func setUnknown(id: NSManagedObjectID) {
        guard let word = context.object(with: id) as? Word else { return }
        word.rightSelection = 0
        word.known = false
        saveChanges()
    }
    
    func incrementRightSelection(id: NSManagedObjectID) {
        guard let word = context.object(with: id) as? Word else { return }
        word.rightSelection += 1
        if word.rightSelection >= 3 {
            word.known = true
        }
        saveChanges()
    }
    
    func setDefault() {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        guard let request = try? context.fetch(fetchRequest) else {
            print(Errors.ErrorGettingWords.rawValue)
            return
        }
        for word in request {
//            word.known = false
//            word.rightSelection = 0
            deleteWord(id: word.objectID)
        }
        addTenWords()
        saveChanges()
    }
    
    //    MARK: - Get words

    func getKnownWords(offset: Int) -> Word? {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let words = try? context.fetch(fetchRequest).first else {
            print(Errors.NoWordsFound.rawValue)
            return nil
        }
        return words
    }
    
    func getNewWords(offset: Int) -> Word? {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = offset
        fetchRequest.predicate = NSPredicate(format: "known = %@", "false")
        guard let words = try? context.fetch(fetchRequest).first else {
            print(Errors.ErrorGettingWords.rawValue)
            return nil
        }
        return words
    }
    
    func getAllWords(offset: Int) -> Word? {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        fetchRequest.fetchOffset = offset
        guard let words = try? context.fetch(fetchRequest).first else {
            print(Errors.ErrorGettingWords.rawValue)
            return nil
        }
        return words
    }
    
    func countOfknownWords() -> Int {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        fetchRequest.predicate = NSPredicate(format: "known != %@", "false")
        guard let count = try? context.count(for: fetchRequest) else {
            print(Errors.ErrorGettingCount.rawValue)
            return 0
        }
        return count
    }
    
    func countOfNewWords() -> Int {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        fetchRequest.fetchLimit = 15
        fetchRequest.predicate = NSPredicate(format: "known = %@", "false")
        guard let count = try? context.count(for: fetchRequest) else {
            print(Errors.ErrorGettingCount.rawValue)
            return 0
        }
        return count
    }
    
    func countOfAllWords() -> Int {
        let fetchRequest = NSFetchRequest<Word>(entityName: Entities.Word.rawValue)
        guard let count = try? context.count(for: fetchRequest) else {
            print(Errors.ErrorGettingCount.rawValue)
            return 0
        }
        return count
    }
    
    private func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Saving error: ", error)
        }
    }
}

