//
//  Progress+CoreDataProperties.swift
//  FlashCards
//
//  Created by Igor Marques Vicente on 04/11/21.
//
//

import Foundation
import CoreData


extension Progress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progress> {
        return NSFetchRequest<Progress>(entityName: "Progress")
    }

    @NSManaged public var date: Date?
    @NSManaged public var status: Bool
    @NSManaged public var card: Card?

}

extension Progress : Identifiable {

}
