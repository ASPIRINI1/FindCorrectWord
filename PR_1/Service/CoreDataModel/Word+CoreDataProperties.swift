//
//  Word+CoreDataProperties.swift
//  PR_1
//
//  Created by Станислав Зверьков on 14.10.2022.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var eng: String
    @NSManaged public var known: Bool
    @NSManaged public var rightSelection: Int64
    @NSManaged public var rus: String

}

extension Word : Identifiable {

}
