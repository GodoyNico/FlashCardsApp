//
//  Content+CoreDataProperties.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 19/10/21.
//
//

import Foundation
import CoreData


extension Content {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Content> {
        return NSFetchRequest<Content>(entityName: "Content")
    }

    @NSManaged public var image: Data?
    @NSManaged public var text: String?

}

extension Content : Identifiable {

}
