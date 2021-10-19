//
//  Card+CoreDataProperties.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 19/10/21.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var back_content: Content?
    @NSManaged public var front_content: Content?
    @NSManaged public var progress: [Progress]?
    @NSManaged public var progress_counter: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var deck: Deck?

}

extension Card : Identifiable {

}
