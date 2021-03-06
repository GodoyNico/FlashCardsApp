//
//  Content+CoreDataProperties.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 08/11/21.
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
    @NSManaged public var back_card: Card?
    @NSManaged public var front_card: Card?

}

extension Content : Identifiable {

}
