//
//  ForCoreDataTest.swift
//  PR_1
//
//  Created by Станислав Зверьков on 13.10.2022.
//

import Foundation

extension CoreDataManager {    
    func addTenWords() {
        if countOfAllWords() > 0 { return }
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
            addWord(eng: word.key, rus: word.value)
        }
    }
}
