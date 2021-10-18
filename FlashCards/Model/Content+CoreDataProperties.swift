//
//  Content+CoreDataProperties.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 18/10/21.
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
    @NSManaged public var card: Card?

}

extension Content : Identifiable {

}
