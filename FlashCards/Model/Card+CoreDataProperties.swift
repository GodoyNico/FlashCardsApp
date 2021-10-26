//
//  Card+CoreDataProperties.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 20/10/21.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var progress_counter: Int16
    @NSManaged public var deck: Deck?
    @NSManaged public var front_content: Content?
    @NSManaged public var back_content: Content?
    @NSManaged public var progress: NSSet?

}

// MARK: Generated accessors for progress
extension Card {

    @objc(addProgressObject:)
    @NSManaged public func addToProgress(_ value: Progress)

    @objc(removeProgressObject:)
    @NSManaged public func removeFromProgress(_ value: Progress)

    @objc(addProgress:)
    @NSManaged public func addToProgress(_ values: NSSet)

    @objc(removeProgress:)
    @NSManaged public func removeFromProgress(_ values: NSSet)

}

extension Card : Identifiable {

}
