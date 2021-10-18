//
//  Deck+CoreDataProperties.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 18/10/21.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var cards: [Card]?
    @NSManaged public var create_date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var progress: Double
    @NSManaged public var title: String?
    @NSManaged public var deck: NSSet?

}

// MARK: Generated accessors for deck
extension Deck {

    @objc(addDeckObject:)
    @NSManaged public func addToDeck(_ value: Card)

    @objc(removeDeckObject:)
    @NSManaged public func removeFromDeck(_ value: Card)

    @objc(addDeck:)
    @NSManaged public func addToDeck(_ values: NSSet)

    @objc(removeDeck:)
    @NSManaged public func removeFromDeck(_ values: NSSet)

}

extension Deck : Identifiable {

}
