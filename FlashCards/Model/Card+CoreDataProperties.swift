//
//  Card+CoreDataProperties.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 18/10/21.
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
    @NSManaged public var id: UUID?
    @NSManaged public var progress: [Progress]?
    @NSManaged public var progress_counter: Int16
    @NSManaged public var content: NSSet?
    @NSManaged public var deck: Deck?
    @NSManaged public var evolution: NSSet?

}

// MARK: Generated accessors for content
extension Card {

    @objc(addContentObject:)
    @NSManaged public func addToContent(_ value: Content)

    @objc(removeContentObject:)
    @NSManaged public func removeFromContent(_ value: Content)

    @objc(addContent:)
    @NSManaged public func addToContent(_ values: NSSet)

    @objc(removeContent:)
    @NSManaged public func removeFromContent(_ values: NSSet)

}

// MARK: Generated accessors for evolution
extension Card {

    @objc(addEvolutionObject:)
    @NSManaged public func addToEvolution(_ value: Progress)

    @objc(removeEvolutionObject:)
    @NSManaged public func removeFromEvolution(_ value: Progress)

    @objc(addEvolution:)
    @NSManaged public func addToEvolution(_ values: NSSet)

    @objc(removeEvolution:)
    @NSManaged public func removeFromEvolution(_ values: NSSet)

}

extension Card : Identifiable {

}
